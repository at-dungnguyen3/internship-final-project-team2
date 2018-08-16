# frozen_string_literal: true

class Bid < ApplicationRecord
  belongs_to :auction_detail
  belongs_to :user
end
