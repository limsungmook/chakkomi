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

ActiveRecord::Schema.define(:version => 20110929110715) do

  create_table "carts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "detail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "item_categories", :force => true do |t|
    t.string   "name"
    t.text     "detail"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "thumnail_pic_file_name"
    t.string   "thumnail_pic_content_type"
    t.integer  "thumnail_pic_file_size"
    t.datetime "thumnail_pic_updated_at"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "product_id"
    t.integer  "cart_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity",   :default => 1
    t.integer  "order_id"
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "account_owner"
    t.text     "address"
    t.string   "phone"
    t.string   "email"
    t.string   "pay_type"
    t.string   "delivery_type"
    t.string   "arrival_payment"
    t.integer  "total_price"
    t.string   "deposit_check"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "category_id"
    t.string   "title"
    t.text     "body_txt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["category_id"], :name => "index_posts_on_category_id"

  create_table "products", :force => true do |t|
    t.integer  "item_category_id"
    t.string   "title"
    t.text     "content"
    t.integer  "price"
    t.string   "delivery_state"
    t.integer  "stock"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "thumnail_pic_file_name"
    t.string   "thumnail_pic_content_type"
    t.integer  "thumnail_pic_file_size"
    t.datetime "thumnail_pic_updated_at"
  end

  add_index "products", ["item_category_id"], :name => "index_products_on_item_category_id"

  create_table "relays", :force => true do |t|
    t.integer  "user_id"
    t.integer  "talk_id"
    t.text     "content",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relays", ["talk_id", "user_id"], :name => "index_relays_on_talk_id_and_user_id"

  create_table "services", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "uname"
    t.string   "uemail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "talks", :force => true do |t|
    t.integer  "user_id"
    t.text     "content",                   :null => false
    t.integer  "secret",     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "talks", ["user_id"], :name => "index_talks_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",   :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",   :null => false
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                     :default => 0
    t.datetime "locked_at"
    t.string   "name"
    t.text     "shortbio"
    t.string   "weburl"
    t.boolean  "haslocalpw",                          :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
