class CreateCheckpoints < ActiveRecord::Migration
  def change
    create_table :checkpoints do |t|
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.integer :user_id
      t.integer :trip_id
      t.string :ip_address
      t.string :street_address

      t.timestamps
    end

    create_table :trips do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
