class ChangeSlotIdTypeInParkingSlots < ActiveRecord::Migration[7.1]
  def change
    change_column :parking_slots, :slot_id, :string
  end
end
