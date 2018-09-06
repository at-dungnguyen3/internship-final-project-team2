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
    if period.negative?
      if has_bids?
        @auction_detail.update_attributes(status: 1)
        decreasing_product_quantity(auction['product_id'])
        add_to_cart
        ActionCable.server.broadcast("finish_#{key}_channel", obj: @auction_detail.bids.last.user_id)
      end
      reset_auction(key)
    end
  end

  def reset_auction(key)
    auction = JSON.parse($redis.get(key))
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

  def has_bids?
    if @auction_detail.bids.any?
      true
    else
      @auction_detail.destroy
      false
    end
  end

  def add_to_cart
    last_bid = @auction_detail.bids.last
    winner = last_bid.user
    orders = winner.orders
    if orders.any? && orders.last.status.zero?
      orders.last.line_items.create!(product_id: @auction_detail.auction.product_id, amount: last_bid.amount)
    else
      orders.create!(status: 0)
      orders.last.line_items.create!(product_id: @auction_detail.auction.product_id, amount: last_bid.amount)
    end
    total_price = orders.last.total_price += last_bid.amount
    orders.last.update_attributes(total_price: total_price)
  end

  def decreasing_product_quantity(product_id)
    $redis.keys('*').each do |e|
      auc = JSON.parse($redis.get(e))
      if auc['product_id'] == product_id
        auc['product_quantity'] = auc['product_quantity'] - 1
        $redis.set(e, auc.to_json)
      end
    end
    Product.find_by(id: product_id).decrement!(:quantity)
  end
end
