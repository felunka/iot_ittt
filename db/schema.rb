# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_04_111234) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sensor_measurements", force: :cascade do |t|
    t.bigint "sensor_id", null: false
    t.float "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sensor_id"], name: "index_sensor_measurements_on_sensor_id"
  end

  create_table "sensors", force: :cascade do |t|
    t.string "name"
    t.integer "sensor_type"
    t.string "topic"
    t.string "url"
    t.integer "interval"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "json_path"
  end

  add_foreign_key "sensor_measurements", "sensors"
end
