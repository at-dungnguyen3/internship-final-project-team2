# frozen_string_literal: true

class CreateAuctionDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :auction_details do |t|
      t.references :auction, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
