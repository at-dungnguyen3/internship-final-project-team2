# frozen_string_literal: true

class AuctionDetail < ApplicationRecord
  belongs_to :auction
  has_many :bids

  scope :is_active, -> { where('status = 0') }
end
