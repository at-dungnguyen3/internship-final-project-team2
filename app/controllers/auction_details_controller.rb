# frozen_string_literal: true

class AuctionDetailsController < ApplicationController
  def top_bider
    @auction_detail = Auction.find_by(id: params[:auction_id]).auction_details.last
    @top_bider = @auction_detail.bids.any? ? @auction_detail.bids.last.user_id : nil
    respond_to do |format|
      format.json { render json: @top_bider }
    end
  end
end
