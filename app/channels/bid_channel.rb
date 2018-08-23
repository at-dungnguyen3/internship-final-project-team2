# frozen_string_literal: true

class BidChannel < ApplicationCable::Channel
  def subscribed
    stream_from "bid_#{params[:auction_id]}_channel"
  end

  def unsubcribed; end
end
