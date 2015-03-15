class CreateServicableCityLocalityLocations < ActiveRecord::Migration
  def change
    create_table :servicable_city_locality_locations do |t|
      t.integer :servicable_city_locality_id
      t.string :location_name
      t.integer :pincode

      t.timestamps null: false
    end
  end
end
