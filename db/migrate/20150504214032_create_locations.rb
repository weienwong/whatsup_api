class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|

      t.string :room
      t.string :building_name

      t.string :address
      t.string :city
      t.string :province

      t.string :postal_code

      t.timestamps
    end
  end
end
