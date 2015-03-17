class Photo < ActiveRecord::Base 
  belongs_to :album
  mount_uploader :image, ImageUploader
  store_in_background :image

end
