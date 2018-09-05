# frozen_string_literal: true

module Admin::OrdersHelper
  def show_order_status(status)
    if status == 0
      content_tag(:span, 'Chưa thanh toán', class: 'btn btn-default')
    elsif status == 1
      content_tag(:span, 'Đang vận chuyển', class: 'btn btn-warning')
    elsif status == 2
      content_tag(:span, 'Đã thanh toán', class: 'btn btn-success')
    else
      content_tag(:span, 'Đã bị hủy', class: 'btn btn-danger')
    end
  end

  def select_status
    [['Chưa thanh toán', 0], ['Đang vận chuyển', 1], ['Đã thanh toán', 2], ['Đã bị hủy', 3]]
  end
end
