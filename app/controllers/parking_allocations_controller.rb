class ParkingAllocationsController < ApplicationController
  before_action :fetch_occupancy_status, only: [:index]
  helper_method :calculate_fee

  def index
    fetch_occupancy_status
    fetch_parking_slots
  end

  def create
    plate_number = params[:plate_number]
    vehicle_type = params[:vehicle_type]
    entrance = ParkingEntrance.first
  
    parking_slot = find_available_slot_for_vehicle(vehicle_type)

    if parking_slot
      if vehicle_type == 'S' && parking_slot.size == 'small'
        update_parking_slot(parking_slot, plate_number, vehicle_type, entrance)
      elsif vehicle_type == 'M' && parking_slot.size == 'medium'
        update_parking_slot(parking_slot, plate_number, vehicle_type, entrance)
      elsif vehicle_type == 'L' && parking_slot.size == 'large'
        update_parking_slot(parking_slot, plate_number, vehicle_type, entrance)
      else
        flash[:alert] = "No available parking slots for #{vehicle_type} vehicles in the selected size category."
        redirect_to root_path
      end
    else
      flash[:alert] = "No available parking slots for #{vehicle_type} vehicles."
      redirect_to root_path
    end
  end
  
  def exit_parking
    plate_number = params[:plate_number_exit]
    hours_rendered = params[:hours_rendered].to_i
    vehicle_type = params[:vehicle_type_exit]

    if vehicle_type.nil?
      parking_slot = ParkingSlot.find_by(plate_number: plate_number)
      vehicle_type = parking_slot.vehicle_type if parking_slot
    end

    parking_slot = ParkingSlot.find_by(plate_number: plate_number)
  
    if parking_slot.nil?
      flash[:alert] = "Vehicle with plate number #{plate_number} is not parked."
      redirect_to root_path
      return
    end


    parking_duration = hours_rendered.to_f
    parking_fee = compute_parking_fee(parking_duration, vehicle_type)
  
    transaction = Transaction.create(
      plate_number: plate_number,
      slot_id: parking_slot.slot_id,
      entry_time: parking_slot.created_at,
      exit_time: Time.now,
      vehicle_type: vehicle_type,
      parking_fee: parking_fee.to_f
    )

    parking_slot.update(occupied: false, plate_number: nil, vehicle_type: nil)
  
    flash[:notice] = "Vehicle with plate number #{plate_number} has exited parking. Parking fee: #{parking_fee}"
    redirect_to root_path
  end
  

  def get_vehicle_type
    plate_number = params[:plate_number]
    parking_slot = ParkingSlot.find_by(plate_number: plate_number)


    if parking_slot
      render json: { vehicle_type: parking_slot.vehicle_type }
    else
      render json: { error: "Vehicle not found" }, status: :not_found
    end
  end

  def calculate_fee
    hours_rendered = params[:hours_rendered].to_i
    vehicle_type = params[:vehicle_type]
  
    flat_rate = 40
    exceeding_hourly_rates = { 'S' => 20, 'M' => 60, 'L' => 100 }
  
    total_fee = flat_rate
  
    if hours_rendered > 3
      remaining_duration = hours_rendered - 3
  
      remaining_fee = 0
      remaining_duration.times do |hour|
        slot_type = parking_slot_type(vehicle_type)
        rate = exceeding_hourly_rates[slot_type] || exceeding_hourly_rates['L']
        remaining_fee += rate
      end
  
      total_fee += remaining_fee
    end
  
    if hours_rendered > 24
      full_chunks = hours_rendered / 24
      total_fee += full_chunks * 5000
    end
  
    if hours_rendered <= 1
      total_fee = flat_rate
    end
  
    render json: { total_amount: total_fee }
  end
  

  
  private

  def compute_parking_fee(parking_duration, vehicle_type)
 
    flat_rate = 40
    exceeding_hourly_rates = { 'S' => 20, 'M' => 60, 'L' => 100 }
  
    total_fee = flat_rate
  
    if parking_duration > 3
      remaining_duration = parking_duration - 3
  
      remaining_fee = 0
      remaining_duration.ceil.times do |hour|
        if hour < remaining_duration.ceil
          rate = exceeding_hourly_rates[vehicle_type] || exceeding_hourly_rates['L']
          remaining_fee += rate
        end
      end
  
      total_fee += remaining_fee
    end
  
    if parking_duration > 24
      full_chunks = parking_duration / 24
      total_fee += full_chunks * 5000
    end
  
    if parking_duration <= 1
      total_fee = flat_rate
    end
  
    total_fee
  end

  
  def update_parking_slot(parking_slot, plate_number, vehicle_type, entrance)
    if parking_slot.update(occupied: true, plate_number: plate_number, vehicle_type: vehicle_type)
      flash[:notice] = "Vehicle with plate number #{plate_number} and type #{vehicle_type} is parked in slot #{parking_slot.number}."
  
      entry_time = entrance.created_at
      exit_time = Time.current
      parking_duration = (exit_time - entry_time) / 1.hour
  
      @parking_fee = compute_parking_fee(parking_duration, vehicle_type)
    else
      flash[:alert] = "Failed to update parking slot. Please try again."
    end
  
    redirect_to root_path
  end

  def fetch_occupancy_status
    @small_occupied = {}
    @medium_occupied = {}
    @large_occupied = {}

    small_slots = ParkingSlot.where(size: "small")
    medium_slots = ParkingSlot.where(size: "medium")
    large_slots = ParkingSlot.where(size: "large")

    small_slots.each { |slot| @small_occupied[slot.number] = slot.occupied }
    medium_slots.each { |slot| @medium_occupied[slot.number] = slot.occupied }
    large_slots.each { |slot| @large_occupied[slot.number] = slot.occupied }
  end

  def fetch_parking_slots
    @small_slots = ParkingSlot.where(size: "small")
    @medium_slots = ParkingSlot.where(size: "medium")
    @large_slots = ParkingSlot.where(size: "large")
  end

  def find_available_slot_for_vehicle(vehicle_type)
    case vehicle_type
    when 'S'
      ParkingSlot.where("(vehicle_type IS NULL OR vehicle_type = ?) AND occupied = ? AND size = ?", vehicle_type, false, 'small').first
    when 'M'
      ParkingSlot.where("(vehicle_type IS NULL OR vehicle_type = ? )AND occupied = ? AND size = ?", vehicle_type, false, 'medium').first
    when 'L'
      ParkingSlot.where("(vehicle_type IS NULL OR vehicle_type = ? )AND occupied = ? AND size = ?", vehicle_type, false, 'large').first
    else
      nil
    end
  end


  

  def parking_slot_type(vehicle_type)
    case vehicle_type
    when 'S'
      'SP'
    when 'M'
      'MP'
    when 'L'
      'LP'
    else
      'LP'
    end
  end
end
