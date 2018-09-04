# frozen_string_literal: true

module Admin
  class OrdersController < AdminController
    before_action :find_order, only: %i[show edit update]

    def index
      @orders = Order.search(params[:term], params[:status]).paginate(page: params[:page], per_page: 10)
    end

    def show
      @line_items = @order.line_items.paginate(page: params[:page], per_page: 10)
    end

    def edit; end

    def update
      if @order.update order_params
        flash[:success] = 'Cập nhập đơn hàng thành công'
        redirect_to admin_orders_path
      else
        render :edit
      end
    end

    private

      def order_params
        params.require(:order).permit(%i[status])
      end

      def find_order
        (@order = Order.find_by(id: params[:id])) or not_found
      end
  end
end
