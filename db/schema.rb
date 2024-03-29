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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120330145614) do

  create_table "combat_logs", :force => true do |t|
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "encounters", :force => true do |t|
    t.integer  "combat_log_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "owner_id"
  end

  create_table "entities", :force => true do |t|
    t.string   "name"
    t.integer  "total_damage"
    t.boolean  "player"
    t.integer  "total_healing"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "encounter_id"
    t.string   "max_damage"
    t.string   "max_healing"
  end

end
