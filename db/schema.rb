# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_03_25_015007) do
  create_table "parking_allocations", force: :cascade do |t|
    t.string "vehicle_plate_number"
    t.string "vehicle_type"
    t.integer "parking_slot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parking_slot_id"], name: "index_parking_allocations_on_parking_slot_id"
  end

  create_table "parking_entrances", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parking_slots", force: :cascade do |t|
    t.integer "number"
    t.boolean "occupied"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "size"
    t.string "vehicle_type"
    t.string "slot_id"
    t.string "plate_number"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "plate_number"
    t.string "slot_id"
    t.datetime "entry_time"
    t.datetime "exit_time"
    t.string "vehicle_type"
    t.integer "parking_fee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "parking_allocations", "parking_slots"
end
