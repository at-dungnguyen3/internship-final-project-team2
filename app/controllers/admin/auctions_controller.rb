# frozen_string_literal: true

module Admin
  class AuctionsController < AdminController
    before_action :find_product, only: %i[index new create]
    before_action :find_auction, only: %i[edit update destroy]

    def index
      @auctions = @product.auctions.paginate(page: params[:page], per_page: 10)
    end

    def new
      @auction = @product.auctions.build
    end

    def create
      @auction = @product.auctions.build(auction_params)
      if @auction.save
        add_to_redis(@auction) if @auction.status == 1
        respond_to do |format|
          format.html { redirect_to admin_product_auctions_url(@product.id), notice: 'Thêm thông tin đấu giá thành công' }
        end
      else
        respond_to do |format|
          format.html { render :new }
        end
      end
    end

    def edit; end

    def update
      respond_to do |format|
        if @auction.update(auction_params)
          update_auction_from_redis(@auction)
          format.html { redirect_to admin_product_auctions_url(@auction.product.id), notice: 'Cập nhập thông tin đấu giá thành công' }
        else
          format.html { render :edit }
        end
      end
    end

    def destroy
      respond_to do |format|
        if @auction.status.zero? && @auction.destroy
          format.html { redirect_to admin_product_auctions_url(@auction.product.id), notice: 'Xóa thành công' }
        else
          format.html { redirect_to admin_product_auctions_url(@auction.product.id), notice: 'Xóa không thành công' }
        end
      end
    end

    private

      def auction_params
        params.require(:auction).permit(%i[start_at end_at bid_step period status])
      end

      def find_product
        (@product = Product.find_by(id: params[:product_id])) || not_found
      end

      def find_auction
        (@auction = Auction.find_by(id: params[:id])) || not_found
      end

      def add_to_redis(auction)
        period = format_time_to_seconds(auction.period)
        data = {
          id: auction.id,
          start_at: auction.start_at,
          end_at: auction.end_at,
          period: period,
          bid_step: auction.bid_step,
          status: auction.status,
          product_id: auction.product_id,
          product_name: auction.product.name,
          product_price: auction.product.price,
          product_quantity: auction.product.quantity,
          product_description: auction.product.description,
          product_description: auction.product.detail,
          product_pictures: auction.product.pictures,
          product_category: auction.product.category_id
        }
        $redis.set(auction.id, data.to_json)
      end

      def update_auction_from_redis(auction)
        if $redis.get(auction.id)
          if auction_params['status'] == 0
            $redis.del(auction.id)
          else
            data = JSON.parse($redis.get(auction.id))
            period = format_time_to_seconds(auction.period)
            data['start_at'] = auction.start_at
            data['end_at'] = auction.end_at
            data['bid_step'] = auction.bid_step
            data['product_id'] = auction.product_id
            data['product_name'] = auction.product.name
            data['product_price'] = auction.product.price
            data['product_description'] = auction.product.description
            data['product_detail'] = auction.product.detail
            data['product_quantity'] = auction.product.quantity
            data['product_pictures'] = auction.product.pictures
            data['product_category'] = auction.product.category_id
            data['period'] = period
            data['status'] = auction.status
            $redis.set(auction.id, data.to_json)
          end
        else
          add_to_redis(@auction) if auction_params['status'] == 1
        end
      end

      def format_time_to_seconds(time)
        time = time.strftime('%H:%M:%S').split(':')
        time[0].to_i * 3600 + time[1].to_i * 60 + time[2].to_i
      end
    end
end
