class Photo < ActiveRecord::Base 
  # Environment-specific direct upload url verifier screens for malicious posted upload locations.
  DIRECT_UPLOAD_URL_FORMAT = %r{\Ahttps:\/\/s3\.amazonaws\.com\/bug-and-bird-blog-assets\/(?<path>uploads\/.+\/(?<filename>.+))\z}.freeze
  
  belongs_to :album
  has_attached_file :upload

  validates :direct_upload_url, presence: true, format: { with: DIRECT_UPLOAD_URL_FORMAT }
    
  before_create :set_upload_attributes
  after_create :queue_processing
  
  # Store an unescaped version of the escaped URL that Amazon returns from direct upload.
  def direct_upload_url=(escaped_url)
    write_attribute(:direct_upload_url, (CGI.unescape(escaped_url) rescue nil))
  end
  
  # Final upload processing step
  def self.transfer_and_cleanup(id)
    photo = Photo.find(id)
    direct_upload_url_data = DIRECT_UPLOAD_URL_FORMAT.match(photo.direct_upload_url)
    s3 = AWS::S3.new
    
    #save original size
    paperclip_file_path = "photos/uploads/#{photo.id}/original/#{direct_upload_url_data[:filename]}"
    s3.buckets[Rails.configuration.aws[:bucket]].objects[paperclip_file_path].copy_from(direct_upload_url_data[:path])

    #save styles
    Paperclip::Attachment.default_options[:styles].each do |style_name, dimensions|
      tmp_image_file_path =  Pathname.new(photo.transform(style_name, dimensions))
      paperclip_file_path = "photos/uploads/#{photo.id}/#{style_name}/#{direct_upload_url_data[:filename]}"

      s3.buckets[Rails.configuration.aws[:bucket]].objects.create(paperclip_file_path, tmp_image_file_path)
    end
 
    photo.processed = true
    photo.save
    
    #delete the original from aws so we're not using up extra storage
    s3.buckets[Rails.configuration.aws[:bucket]].objects[direct_upload_url_data[:path]].delete 
  end

  def transform style_name, dimensions
    image = MiniMagick::Image.open(upload(:original))

    image.combine_options do |c|
      c.auto_orient
      c.resize(dimensions)
      c.gravity "center"
      c.crop "#{dimensions}+0+0"
    end

    return image.path 
  end
      
  protected
  
  # Set attachment attributes from the direct upload
  # @note Retry logic handles S3 "eventual consistency" lag.
  def set_upload_attributes
    tries ||= 5
    direct_upload_url_data = DIRECT_UPLOAD_URL_FORMAT.match(direct_upload_url)
    s3 = AWS::S3.new
    direct_upload_head = s3.buckets[Rails.configuration.aws[:bucket]].objects[direct_upload_url_data[:path]].head
 
    self.upload_file_name     = direct_upload_url_data[:filename]
    self.upload_file_size     = direct_upload_head.content_length
    self.upload_content_type  = direct_upload_head.content_type
    self.upload_updated_at    = direct_upload_head.last_modified
  rescue AWS::S3::Errors::NoSuchKey => e
    tries -= 1
    if tries > 0
      sleep(3)
      retry
    else
      false
    end
  end
  
  # Queue file processing
  def queue_processing
    Photo.transfer_and_cleanup(id)
  end
 
end
