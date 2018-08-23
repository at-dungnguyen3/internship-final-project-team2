# frozen_string_literal: true

require 'backgrounds/format_time_to_seconds'

class AuctionData
  def push_all_data(key, data)
    obj = JSON.parse($redis.get(key))
    now = FormatTimeToSeconds.format_time_to_seconds(Time.now)
    start_at = FormatTimeToSeconds.format_time_to_seconds(obj['start_at'].to_time)
    auction = Auction.find_by(id: obj['id'])
    @auction_detail = auction.auction_details.last
    if now == start_at && (!@auction_detail || @auction_detail.status == 1)
      @auction_detail = auction.auction_details.create!(status: 0)
    elsif @auction_detail&.status&.zero?
      decreasing_time(key)
      finish_auction(key)
      obj = JSON.parse($redis.get(key))
      ActionCable.server.broadcast("auction_#{key}_channel", obj: obj)
      data << obj
    else
      nil
    end
  end

  def decreasing_time(key)
    auction = JSON.parse($redis.get(key))
    auction['period'] = auction['period'] - 1
    $redis.set(key, auction.to_json)
  end

  def finish_auction(key)
    auction = JSON.parse($redis.get(key))
    period = auction['period']
    reset_auction(auction) if period.negative?
  end

  def reset_auction(auction)
    @auction_detail.update_attributes(status: 1)
    # auction['product_quantity'] = auction['product_quantity'] - 1 if @auction_detail.bids.any?
    auction['period'] = load_period_default(auction['id'])
    auction['product_price'] = load_price_default(auction['id'])

    end_at = FormatTimeToSeconds.format_time_to_seconds(auction['end_at'].to_time)
    now = FormatTimeToSeconds.format_time_to_seconds(Time.now)

    @auction_detail = Auction.find_by(id: auction['id']).auction_details.create!(status: 0) if end_at > now && auction['product_quantity'].positive?

    $redis.set(auction['id'], auction.to_json)
  end

  def load_period_default(id)
    auction = Auction.find_by(id: id)
    FormatTimeToSeconds.format_time_to_seconds(auction.period)
  end

  def load_price_default(id)
    auction = Auction.find_by(id: id)
    auction.product.price
  end
end
