class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.date :date_of_birth
      t.text :bio
      t.decimal :last_location_lat
      t.decimal :last_location_lon
      t.integer :last_zipcode
      t.boolean :active_user, default: false

      t.timestamps
    end
  end
end
