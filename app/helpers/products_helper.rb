# frozen_string_literal: true

module ProductsHelper
  def show_product_quantity(quantity)
    if quantity > 0
      content_tag(:span, 'Còn hàng', class: 'btn btn-warning')
    else
      content_tag(:span, 'Hết hàng', class: 'btn btn-danger')
    end
  end
end
