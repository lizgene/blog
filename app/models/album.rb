class Album < ActiveRecord::Base
  has_many :photos

  accepts_nested_attributes_for :photos

  def cover_photo_url
    photos.first.upload(:medium) rescue "bay-bridge.jpg"
  end
end
