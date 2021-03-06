# frozen_string_literal: true

class AuctionDetail < ApplicationRecord
  belongs_to :auction
  has_many :bids, dependent: :destroy

  scope :is_active, -> { where('auction_details.status = 0') }
  scope :bids_of_user, ->(id) { joins(:bids).where('bids.user_id = ?', id).order('bids.updated_at DESC') }
  scope :is_finish, -> { where('auction_details.status = 1') }

  def self.bid(data, key)
    auction = JSON.parse($redis.get(key))
    auction_detail = Auction.find_by(id: key).auction_details.last
    flag = false
    if auction_detail.bids.any?
      user_bids = auction_detail.bids.of_user(data['user_id'].to_i)
      auction_detail.bids.not_of_user(data['user_id'].to_i).each do |bid|
        bid.update_attributes(status: 0)
      end
      if user_bids.any?
        if user_bids.first.status.zero?
          flag = true
          user_bids.first.update_attributes(amount: data['amount'], created_at: Time.now, status: 1)
        else
          flag = false
        end
      else
        auction_detail.bids.create!(user_id: data['user_id'].to_i, amount: data['amount'], status: 1)
        flag = true
      end
    else
      auction_detail.bids.create!(user_id: data['user_id'].to_i, amount: data['amount'], status: 1)
      flag = true
    end
    if flag == true
      auction['product_price'] = data['amount'].to_i
      auction['period'] = 20 if auction['period'] < 20
      $redis.set(key, auction.to_json)
    end
    AuctionDetail.load_bids(key, auction_detail)
  end

  def self.load_bids(key, auction_detail)
    data = []
    auction_detail.bids.newest.each do |e|
      obj = {
        name: e.user.last_name + ' ' + e.user.first_name,
        amount: e.amount,
        created_at: e.created_at
      }
      data << obj
    end
    ActionCable.server.broadcast("bid_#{key}_channel", list: data)
  end
end
