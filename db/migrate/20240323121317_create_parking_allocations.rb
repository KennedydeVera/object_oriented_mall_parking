class CreateParkingAllocations < ActiveRecord::Migration[7.1]
  def change
    create_table :parking_allocations do |t|
      t.string :vehicle_plate_number
      t.string :vehicle_type
      t.references :parking_slot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
