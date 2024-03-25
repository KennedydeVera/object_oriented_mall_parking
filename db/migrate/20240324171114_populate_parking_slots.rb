class PopulateParkingSlots < ActiveRecord::Migration[7.1]
  def up
    # Populate small parking slots
    30.times do |i|
      ParkingSlot.create!(number: i + 1, size: 'small', occupied: false)
    end

    # Populate medium parking slots
    20.times do |i|
      ParkingSlot.create!(number: i + 1, size: 'medium', occupied: false)
    end

    # Populate large parking slots
    10.times do |i|
      ParkingSlot.create!(number: i + 1, size: 'large', occupied: false)
    end
  end

  def down
    # Rollback logic if needed
    ParkingSlot.delete_all
  end
end
