class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name,:null=>false
      t.string :created_by,:null=>false
      t.string :updated_by,:null=>false

      t.timestamps
    end
  end
end
