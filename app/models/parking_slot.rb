class ParkingSlot < ApplicationRecord
  enum size: { small: 'small', medium: 'medium', large: 'large' }
  validates :plate_number, uniqueness: true, allow_nil: true
end
