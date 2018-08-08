class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username, null: false, unique: true
      t.string :email, null: false, index: true, unique: true
      t.string :password_digest
      t.string :role, null: false, default: 'user'
      t.datetime :last_login
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
