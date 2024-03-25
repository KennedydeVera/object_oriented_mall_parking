class AddVehicleTypeToParkingSlots < ActiveRecord::Migration[7.1]
  def change
    add_column :parking_slots, :vehicle_type, :string
  end
end
