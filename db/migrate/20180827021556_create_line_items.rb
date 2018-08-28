# frozen_string_literal: true

class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :line_items do |t|
      t.references :order, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :amount

      t.timestamps
    end
  end
end
