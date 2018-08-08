# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :password_digest
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
