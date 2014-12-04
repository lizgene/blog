class CreateAlbumsAndPhotos < ActiveRecord::Migration
  def up
    create_table :albums do |t|
      t.string :title
      t.text :description
      t.integer :cover_photo_id

      t.timestamps
    end

    create_table :photos do |t|
      t.integer :album_id
      t.string :direct_upload_url, null: false
      t.attachment :upload
      t.boolean :processed, default: false, null: false

      t.timestamps
    end
    add_index :photos, :album_id
    add_index :photos, :processed
  end

  def down
    drop_table :albums
    drop_table :photos
  end
end