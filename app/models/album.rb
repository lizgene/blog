class Album < ActiveRecord::Base
  has_many :photos, :inverse_of => :album

  accepts_nested_attributes_for :photos

  def cover_photo_url
    photos.first.image.medium rescue "bay-bridge.jpg"
  end
end
