# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_180_830_095_441) do
  create_table 'auction_details', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.bigint 'auction_id'
    t.integer 'status'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['auction_id'], name: 'index_auction_details_on_auction_id'
  end

  create_table 'auctions', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.bigint 'product_id'
    t.time 'start_at'
    t.time 'end_at'
    t.time 'period'
    t.integer 'bid_step', default: 0
    t.integer 'status', default: 0
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['product_id'], name: 'index_auctions_on_product_id'
  end

  create_table 'bids', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.bigint 'auction_detail_id'
    t.bigint 'user_id'
    t.integer 'amount'
    t.integer 'status'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['auction_detail_id'], name: 'index_bids_on_auction_detail_id'
    t.index ['user_id'], name: 'index_bids_on_user_id'
  end

  create_table 'categories', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'name', null: false
    t.bigint 'categories_id'
    t.index ['categories_id'], name: 'index_categories_on_categories_id'
    t.index ['name', 'categories_id'], name: 'index_categories_on_name_and_categories_id', unique: true
  end

  create_table 'ckeditor_assets', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'data_file_name', null: false
    t.string 'data_content_type'
    t.integer 'data_file_size'
    t.string 'type', limit: 30
    t.integer 'width'
    t.integer 'height'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['type'], name: 'index_ckeditor_assets_on_type'
  end

  create_table 'line_items', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.bigint 'order_id'
    t.bigint 'product_id'
    t.integer 'amount'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['order_id'], name: 'index_line_items_on_order_id'
    t.index ['product_id'], name: 'index_line_items_on_product_id'
  end

  create_table 'orders', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.bigint 'user_id'
    t.string 'address'
    t.string 'phone'
    t.integer 'total_price'
    t.integer 'status'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_orders_on_user_id'
  end

  create_table 'pictures', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.bigint 'product_id'
    t.string 'image'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['product_id'], name: 'index_pictures_on_product_id'
  end

  create_table 'products', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'name', null: false
    t.text 'description', null: false
    t.text 'detail', null: false
    t.integer 'quantity', default: 0
    t.integer 'price', default: 0
    t.bigint 'category_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['category_id'], name: 'index_products_on_category_id'
  end

  create_table 'users', options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8', force: :cascade do |t|
    t.string 'email'
    t.string 'first_name', null: false
    t.string 'last_name', null: false
    t.string 'password_digest'
    t.integer 'role', default: 0
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'activation_digest'
    t.boolean 'activated?', default: false
    t.datetime 'activated_at'
    t.string 'remember_digest'
    t.string 'provider'
    t.string 'uid'
  end

  add_foreign_key 'auction_details', 'auctions'
  add_foreign_key 'auctions', 'products'
  add_foreign_key 'bids', 'auction_details'
  add_foreign_key 'bids', 'users'
  add_foreign_key 'line_items', 'orders'
  add_foreign_key 'line_items', 'products'
  add_foreign_key 'orders', 'users'
  add_foreign_key 'products', 'categories'
end
