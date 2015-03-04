class Album < ActiveRecord::Base
  has_many :photos, :inverse_of => :album
  accepts_nested_attributes_for :photos, allow_destroy: true
  validates_presence_of :slug

  before_destroy :destroy_photos
  before_validation :set_slug, :on => :create

  def set_slug
    self.slug = self.title.downcase.gsub(" ", "-")
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
