# frozen_string_literal: true

module AuctionDetailsHelper
  def show_bids_status(status)
    if status == 1
      content_tag(:span, 'Win', class: 'btn btn-success')
    else
      content_tag(:span, 'Lose', class: 'btn btn-danger')
    end
  end
end
