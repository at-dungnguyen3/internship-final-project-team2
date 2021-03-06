# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.string :address
      t.string :phone
      t.integer :total_price, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
