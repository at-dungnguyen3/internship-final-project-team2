# frozen_string_literal: true

module Admin::AuctionsHelper
  def show_status(obj)
    if obj.status.zero?
      content_tag(:span, 'Chưa kích hoạt', class: 'btn btn-default disabled')
    else
      content_tag(:span, 'Đã kích hoạt', class: 'btn btn-success')
    end
  end
end
