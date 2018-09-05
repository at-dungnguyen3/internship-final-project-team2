# frozen_string_literal: true

module Admin::AuctionDetailsHelper
  def show_auction_detail_status(status)
    if status.zero?
      content_tag(:span, 'Đang đấu giá', class: 'btn btn-primary')
    else
      content_tag(:span, 'Đã kết thúc', class: 'btn btn-success')
    end
  end
end
