class CreateServicableCityLocalities < ActiveRecord::Migration
  def change
    create_table :servicable_city_localities do |t|
      t.integer :servicable_city_id
      t.string :locality_name

      t.timestamps null: false
    end
  end
end
