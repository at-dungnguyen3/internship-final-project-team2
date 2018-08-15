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
      respond_to do |format|
        if @auction.save
          format.html { redirect_to admin_product_auctions_url(@product.id), notice: 'Thêm thông tin đấu giá thành công' }
        else
          format.html { render :new }
        end
      end
    end

    def edit; end

    def update
      respond_to do |format|
        if @auction.update(auction_params)
          format.html { redirect_to admin_product_auctions_url(@auction.product.id), notice: 'Cập nhập thông tin đấu giá thành công' }
        else
          format.html { render :edit }
        end
      end
    end

    def destroy
      respond_to do |format|
        if @auction.destroy
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
  end
end
