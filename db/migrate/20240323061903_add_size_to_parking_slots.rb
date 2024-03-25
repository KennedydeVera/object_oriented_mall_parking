class AddSizeToParkingSlots < ActiveRecord::Migration[7.1]
  def change
    add_column :parking_slots, :size, :string
  end
end
