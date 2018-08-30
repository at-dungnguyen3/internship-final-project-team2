# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  scope :in_cart, ->(id) { joins(:order).where('status < 2 AND product_id = ?', id) }
end
