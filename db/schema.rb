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

ActiveRecord::Schema.define(version: 20180912005044) do

  create_table "images", force: :cascade do |t|
    t.string "code"
    t.string "filename"
    t.string "extension"
    t.binary "imagefile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["filename"], name: "index_images_on_filename", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.string "code"
    t.text "catchcopy"
    t.integer "weight_g"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "maker_code"
    t.string "genre_code"
    t.string "change_note"
    t.string "sch_release_date"
    t.string "size"
    t.string "package_size"
    t.decimal "package_weight"
    t.string "size_note"
    t.string "battery"
    t.string "catchcopy_main"
    t.string "catchcopy_long"
    t.string "catchcopy_sub1"
    t.string "catchcopy_sub2"
    t.string "catchcopy_sub3"
    t.string "discription"
    t.string "usage"
    t.string "care"
    t.string "detailed_description"
    t.string "caution"
    t.string "description_path1"
    t.string "description_path2"
    t.string "target_age"
    t.string "accessories"
    t.string "manufacture"
    t.string "material"
    t.string "country_origin"
    t.integer "inner_carton"
    t.decimal "outer_carton"
    t.string "outer_size"
    t.decimal "outer_weight"
    t.boolean "cataloged"
    t.string "catalog_copy"
  end

end
