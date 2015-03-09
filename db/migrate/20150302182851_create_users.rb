class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name
      t.string :status,     null: false, default: "active"
      t.string :email,      null: false
      t.string :password,   null: false
      t.integer :address_id
      t.timestamps null: false
    end
  end
end
