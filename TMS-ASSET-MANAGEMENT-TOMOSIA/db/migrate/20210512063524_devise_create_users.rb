class DeviseCreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :name
      t.integer :role, null: false, default: 0
      t.string :phone_number

      t.string   :reset_password_token
      t.datetime :reset_password_sent_at
      t.string   :address

      t.datetime :remember_created_at

      t.timestamps null: false

      t.references :project
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true

  end
end
