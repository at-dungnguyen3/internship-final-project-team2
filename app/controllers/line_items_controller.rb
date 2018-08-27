# frozen_string_literal: true

class LineItemsController < ApplicationController
  before_action :logged_in_user
  before_action :find_unpay_order_of_current_user, only: %i[index destroy]
  before_action :find_line_item, only: :destroy

  def index
    if @order
      @line_items = @order.line_items
      @total_price = 0
      @line_items.each do |e|
        @total_price += e.amount
      end
    end
  end

  def destroy
    product_id = @line_item.product_id
    if @line_item.destroy
      $redis.keys('*').each do |e|
        auction = JSON.parse($redis.get(e))
        auction['product_quantity'] = auction['product_quantity'] + 1 if auction['product_id'] == product_id
        $redis.set(auction['id'], auction.to_json)
      end
      Product.find_by(id: product_id).increment!(:quantity)
    else
      flash[:danger] = 'Xóa không thành công'
    end
    redirect_to line_items_path
  end

  private

    def find_unpay_order_of_current_user
      @order = Order.unpay.find_by(user_id: current_user.id)
    end

    def find_line_item
      (@line_item = @order.line_items.find_by(id: params[:id])) or not_found
    end
end
