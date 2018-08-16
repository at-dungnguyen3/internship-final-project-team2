# frozen_string_literal: true

class CreateBids < ActiveRecord::Migration[5.2]
  def change
    create_table :bids do |t|
      t.references :auction_detail, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :amount
      t.integer :status

      t.timestamps
    end
  end
end
