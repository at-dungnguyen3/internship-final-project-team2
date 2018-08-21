# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.text :detail, null: false
      t.integer :quantity, default: 0
      t.integer :price, default: 0
      t.integer :period, default: 0
      t.integer :bid_step, default: 0
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
