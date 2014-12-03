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
      t.string :url

      t.timestamps
    end
    add_index :photos, :album_id
  end

  def down
    drop_table :albums
    drop_table :photos
    remove_index :photos, :album_id
  end
end
