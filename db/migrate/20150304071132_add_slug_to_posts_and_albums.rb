class AddSlugToPostsAndAlbums < ActiveRecord::Migration
  def change
    add_column :posts, :slug, :string
    add_column :albums, :slug, :string
  end
end
