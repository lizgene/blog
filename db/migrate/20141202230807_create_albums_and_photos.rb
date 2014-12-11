class CreateAlbumsAndPhotos < ActiveRecord::Migration
  def up
    create_table :albums do |t|
      t.string :title
      t.text :description

      t.timestamps
    end

    create_table :photos do |t|
      t.integer :album_id
      t.string :image

      t.timestamps
    end
    add_index :photos, :album_id
  end

  def down
    drop_table :albums
    drop_table :photos
  end
end