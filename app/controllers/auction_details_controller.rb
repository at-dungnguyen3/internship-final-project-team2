# frozen_string_literal: true

class AuctionDetailsController < ApplicationController
  before_action :logged_in_user, only: :index
  before_action :correct_user, only: :index

  def index
    @active = AuctionDetail.is_active.bids_of_user(current_user.id).paginate(page: params[:page], per_page: 5)
    @finished = AuctionDetail.is_finish.bids_of_user(current_user.id).paginate(page: params[:page], per_page: 5)
  end

  def top_bider
    @auction_detail = Auction.find_by(id: params[:auction_id]).auction_details.last
    @top_bider = @auction_detail.bids.any? ? @auction_detail.bids.last.user_id : nil
    respond_to do |format|
      format.json { render json: @top_bider }
    end
  end

  private

    def correct_user
      @user = User.find_by(id: params[:user_id])
      redirect_to root_path unless current_user?(@user)
    end
end
