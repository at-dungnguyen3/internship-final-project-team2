# frozen_string_literal: true

module Admin
  class StaticPagesController < AdminController
    def home
      @users_size = User.all.size
      @categories_size = Category.all.size
      @products_size = Product.all.size
      @orders_size = Order.all.size
    end

    def chart_users
      chart    = []
      wday     = DateTime.now.wday
      daytime  = DateTime.now.to_date
      if wday == 1
        chart << [daytime, User.where('DATE(created_at) = ?', daytime).size]
      else
        while wday >= 1
          chart << [daytime, User.where('DATE(created_at) = ?', daytime).size]
          wday -= 1
          daytime -= 1
        end
      end
      respond_to do |format|
        format.json { render json: chart }
      end
    end

    def chart_orders
      chart    = []
      wday     = DateTime.now.wday
      daytime  = DateTime.now.to_date
      if wday == 1
        chart << [daytime, Order.where('DATE(created_at) = ?', daytime).size]
      else
        while wday >= 1
          chart << [daytime, Order.not_cart.where('DATE(created_at) = ?', daytime).size]
          wday -= 1
          daytime -= 1
        end
      end
      respond_to do |format|
        format.json { render json: chart }
      end
    end
  end
end
