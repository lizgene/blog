class AddSingleAccessTokenToUsers < ActiveRecord::Migration
  def up
    add_column :users, :single_access_token, :string
  end

  def down
    remove_column :users, :single_access_token
  end
end
