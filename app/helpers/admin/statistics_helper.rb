# frozen_string_literal: true

module Admin::StatisticsHelper
  def select_type
    [['Tài khoản', :User], ['Đơn hàng', :Order], ['Phiên đấu giá', :AuctionDetail]]
  end

  def type_description(type)
    if type == 'User'
      'tài khoản'
    elsif type == 'Order'
      'đơn hàng'
    elsif type == 'AuctionDetail'
      'phiên đấu giá'
    end
  end
end
