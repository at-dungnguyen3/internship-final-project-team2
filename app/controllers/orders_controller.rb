# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :correct_order, only: %i[edit update]

  def edit; end

  def update
    if @order.update(order_params)
      update_total_price(@order)
      flash[:success] = 'Đặt hàng thành công'
      redirect_to root_path
    else
      render :edit
    end
  end

  private

    def order_params
      params.require(:order).permit(%i[address phone status])
    end

    def correct_order
      @order = Order.unpay.find_by(user_id: current_user.id)
      return @order if @order && @order.id == params[:id].to_i
      redirect_to root_path
    end

    def update_total_price(order)
      total_price = 0
      order.line_items.each do |e|
        total_price += e.amount
      end
      order.update_attributes(total_price: total_price)
    end
end
