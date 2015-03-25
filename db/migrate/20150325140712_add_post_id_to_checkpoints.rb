class AddPostIdToCheckpoints < ActiveRecord::Migration
  def change
    add_column :checkpoints, :post_id, :integer
  end
end
