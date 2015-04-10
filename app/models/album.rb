class Album < ActiveRecord::Base
  has_many :photos, :inverse_of => :album
  accepts_nested_attributes_for :photos, allow_destroy: true
  validates_presence_of :title
  
  before_create :set_slug
  before_destroy :destroy_photos
  is_impressionable


  def set_slug
    self.slug = self.title.parameterize 
  end

  def to_param
    slug
  end

  def cover_photo_url
    photos.first.image.medium rescue "bay-bridge.jpg"
  end

  def destroy_photos
    photos.destroy_all
  end
end
