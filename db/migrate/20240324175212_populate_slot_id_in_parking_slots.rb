class PopulateSlotIdInParkingSlots < ActiveRecord::Migration[7.1]
  def up
    # Populate slot_id for small vehicles (SP1 to SP30)
    (1..30).each do |i|
      ParkingSlot.where(size: 'small', number: i).update_all(slot_id: "SP#{i}")
    end

    # Populate slot_id for medium vehicles (MP1 to MP20)
    (1..20).each do |i|
      ParkingSlot.where(size: 'medium', number: i).update_all(slot_id: "MP#{i}")
    end

    # Populate slot_id for large vehicles (LP1 to LP10)
    (1..10).each do |i|
      ParkingSlot.where(size: 'large', number: i).update_all(slot_id: "LP#{i}")
    end
  end

  def down
    # In case you need to rollback the migration, you can reset the slot_id values
    ParkingSlot.update_all(slot_id: nil)
  end
end
