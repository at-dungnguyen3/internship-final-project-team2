# frozen_string_literal: true

class RemoveAttributeFromProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :period
    remove_column :products, :bid_step
  end
end
