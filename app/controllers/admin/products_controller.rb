# frozen_string_literal: true

module Admin
  class ProductsController < AdminController
    before_action :find_product, except: %i[index new create]

    def index
      @products = Product.search(params[:term]).paginate(page: params[:page], per_page: 10)
    end

    def show
      @pictures = @product.pictures
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)
      respond_to do |format|
        if @product.save
          if params[:pictures]
            params[:pictures][:image].each do |a|
              @picture = @product.pictures.create!(image: a)
            end
          end
          format.html { redirect_to admin_products_path, flash: { success: 'Thêm sản phẩm thành công' } }
        else
          format.html { render action: :new }
        end
      end
    end

    def edit; end

    def update
      respond_to do |format|
        if @product.update(product_params)
          if params[:pictures]
            params[:pictures][:image].each do |a|
              @picture = @product.pictures.create!(image: a)
            end
          end
          update_product_in_redis(@product)
          format.html { redirect_to admin_products_path, flash: { success: 'Cập nhập sản phẩm thành công' } }
        else
          format.html { render action: :edit }
        end
      end
    end

    def destroy
      product_in_cart = LineItem.in_cart(@product.id)
      if product_in_cart.none? && @product.destroy
        flash[:success] = 'Xóa sản phẩm thành công'
      else
        flash[:danger] = 'Xóa sản phẩm thất bại. Sản phẩm vẫn còn trong giỏ hàng chưa thanh toán'
      end
      redirect_to admin_products_path
    end

    private

      def product_params
        params.require(:product).permit(:name, :description, :detail, :quantity, :price, :category_id, pictures_attributes: %i[id product_id image _destroy])
      end

      def find_product
        (@product = Product.find_by(id: params[:id])) || not_found
      end

      def update_product_in_redis(product)
        $redis.keys('*').each do |key|
          auction = JSON.parse($redis.get(key))
          next unless auction['product_id'] == product.id
          auction['product_name'] = product.name
          auction['product_price'] = product.price
          auction['product_description'] = product.description
          auction['product_detail'] = product.detail
          auction['product_quantity'] = product.quantity
          auction['product_pictures'] = product.pictures
          auction['product_category'] = product.category_id
          $redis.set(key, auction.to_json)
        end
      end
  end
end
