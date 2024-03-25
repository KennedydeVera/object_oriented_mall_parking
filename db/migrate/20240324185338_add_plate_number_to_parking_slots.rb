class AddPlateNumberToParkingSlots < ActiveRecord::Migration[7.1]
  def change
    add_column :parking_slots, :plate_number, :string
  end
end
