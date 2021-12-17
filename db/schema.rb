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

ActiveRecord::Schema.define(version: 2021_12_17_080153) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ittt_actions", force: :cascade do |t|
    t.bigint "ittt_id", null: false
    t.string "topic"
    t.string "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "send_evaluation_output", default: false
    t.index ["ittt_id"], name: "index_ittt_actions_on_ittt_id"
  end

  create_table "ittt_conditions", force: :cascade do |t|
    t.bigint "ittt_id", null: false
    t.bigint "sensor_1_id", null: false
    t.bigint "sensor_2_id"
    t.float "comparison_value"
    t.integer "operation", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ittt_id"], name: "index_ittt_conditions_on_ittt_id"
    t.index ["sensor_1_id"], name: "index_ittt_conditions_on_sensor_1_id"
    t.index ["sensor_2_id"], name: "index_ittt_conditions_on_sensor_2_id"
  end

  create_table "ittts", force: :cascade do |t|
    t.string "name"
    t.integer "interval"
    t.datetime "last_evaluated_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "trigger_on_sensor_update", default: false
  end

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
    t.integer "toleranz"
  end

  add_foreign_key "ittt_actions", "ittts"
  add_foreign_key "ittt_conditions", "ittts"
  add_foreign_key "ittt_conditions", "sensors", column: "sensor_1_id"
  add_foreign_key "ittt_conditions", "sensors", column: "sensor_2_id"
  add_foreign_key "sensor_measurements", "sensors"
end
