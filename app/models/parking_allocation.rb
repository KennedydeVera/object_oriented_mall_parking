class ParkingAllocation < ApplicationRecord
  belongs_to :parking_slot

  validates :vehicle_plate_number, presence: true
  validates :vehicle_type, inclusion: { in: %w(S M L), message: "%{value} is not a valid vehicle type" }

  def self.allocate_parking(vehicle_plate_number, vehicle_type)
    parking_slot = find_available_slot_for_vehicle(vehicle_type)
    if parking_slot
      parking_slot.update(occupied: true)
      create(vehicle_plate_number: vehicle_plate_number, vehicle_type: vehicle_type, parking_slot: parking_slot)
    else
      nil
    end
  end

  private

  def self.find_available_slot_for_vehicle(vehicle_type)
    ParkingSlot.where("vehicle_type = ? AND occupied = ?", vehicle_type, false).first
  end
end
