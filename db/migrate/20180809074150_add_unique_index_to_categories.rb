# frozen_string_literal: true

class AddUniqueIndexToCategories < ActiveRecord::Migration[5.2]
  def change
    add_index :categories, %i[name categories_id], unique: true
  end
end
