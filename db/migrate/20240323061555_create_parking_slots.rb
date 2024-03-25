class CreateParkingSlots < ActiveRecord::Migration[7.1]
  def change
    create_table :parking_slots do |t|
      t.integer :number
      t.boolean :occupied

      t.timestamps
    end
  end
end
