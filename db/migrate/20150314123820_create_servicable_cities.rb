class CreateServicableCities < ActiveRecord::Migration
  def change
    create_table :servicable_cities do |t|
      t.string :city_name
      t.string :state

      t.timestamps null: false
    end
  end
end
