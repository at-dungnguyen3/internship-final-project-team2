# frozen_string_literal: true

class AuctionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "auction_#{params[:auction_id]}_channel"
  end

  def unsubcribed; end
end
