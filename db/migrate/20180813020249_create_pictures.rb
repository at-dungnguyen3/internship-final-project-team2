# frozen_string_literal: true

class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.references :product
      t.string :image

      t.timestamps
    end
  end
end
