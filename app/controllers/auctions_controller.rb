# frozen_string_literal: true

class AuctionsController < ApplicationController
  before_action :logged_in_user
  before_action :find_auction, only: :show

  def show
    redirect_to root_path unless @auction.auction_details.last.status.zero?
    @product = @auction.product
  end

  private

    def find_auction
      (@auction = Auction.find_by(id: params[:id])) or not_found
    end
end
