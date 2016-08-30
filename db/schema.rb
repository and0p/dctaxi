# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160830042650) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "steps", force: true do |t|
    t.integer  "distance"
    t.integer  "duration"
    t.decimal  "start_lat"
    t.decimal  "start_lon"
    t.decimal  "end_lat"
    t.decimal  "end_lon"
    t.string   "instructions"
    t.text     "polyline"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "trip_id"
  end

  create_table "trips", force: true do |t|
    t.integer  "tdms_id"
    t.string   "provider_type"
    t.string   "provider"
    t.float    "fare"
    t.float    "tip"
    t.float    "surcharge"
    t.float    "extras"
    t.float    "tolls"
    t.float    "total"
    t.string   "payment_type"
    t.string   "payment_provider"
    t.date     "start_date"
    t.datetime "pickup_time"
    t.datetime "dropoff_time"
    t.decimal  "pickup_lat"
    t.decimal  "pickup_long"
    t.string   "pickup_address"
    t.string   "pickup_city"
    t.string   "pickup_state"
    t.string   "pickup_postcode"
    t.decimal  "dropoff_lat"
    t.decimal  "dropoff_lon"
    t.string   "dropoff_address"
    t.string   "dropoff_city"
    t.string   "dropoff_state"
    t.string   "dropoff_postcode"
    t.float    "mileage"
    t.integer  "time"
    t.decimal  "northeast_bound_lat"
    t.decimal  "northeast_bound_long"
    t.decimal  "southeast_bound_lat"
    t.decimal  "southeast_bound_lon"
    t.text     "polyline"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
