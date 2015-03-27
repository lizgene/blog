class AddTitleToCheckpoints < ActiveRecord::Migration
  def change
    add_column :checkpoints, :title, :string
  end
end
