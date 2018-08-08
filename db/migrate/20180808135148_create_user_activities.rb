class CreateUserActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :user_activities do |t|
      t.integer :user_id
      t.float :last_location_lat
      t.float :last_location_lon
      t.integer :last_zipcode
      t.boolean :active_user, default: false

      t.timestamps
    end
  end
end
