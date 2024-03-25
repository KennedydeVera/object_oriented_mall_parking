class AddSlotIdToParkingSlots < ActiveRecord::Migration[7.1]
  def change
    add_column :parking_slots, :slot_id, :integer
  end
end
