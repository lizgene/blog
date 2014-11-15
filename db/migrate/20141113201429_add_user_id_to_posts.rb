class AddUserIdToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :user_id, :integer
    add_index :posts, :user_id
  end

  def down
    remove_column :posts, :user_id
    remove_index :psots, :user_id
  end
end
