# frozen_string_literal: true

class CreateAuctions < ActiveRecord::Migration[5.2]
  def change
    create_table :auctions do |t|
      t.references :product, foreign_key: true
      t.time :start_at
      t.time :end_at
      t.time :period
      t.integer :bid_step, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
