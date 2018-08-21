# frozen_string_literal: true

class AuctionsController < ApplicationController
  before_action :find_auction, only: :show

  def show
    @product = @auction.product
  end

  private

    def find_auction
      (@auction = Auction.find_by(id: params[:id])) or not_found
    end
end
