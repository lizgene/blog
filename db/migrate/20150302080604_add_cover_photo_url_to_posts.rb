class AddCoverPhotoUrlToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :cover_photo_url, :string
  end
end
