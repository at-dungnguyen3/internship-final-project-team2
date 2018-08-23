# frozen_string_literal: true

class Bid < ApplicationRecord
  belongs_to :auction_detail
  belongs_to :user

  scope :in_auction_detail, ->(auction_detail_id) do
    where("auction_detail_id = #{auction_detail_id}")
  end
  scope :of_user, ->(user_id) { where("user_id = #{user_id}") }
  scope :not_of_user, ->(user_id) { where("user_id != #{user_id}") }
  scope :newest, -> { order('created_at DESC') }
end
