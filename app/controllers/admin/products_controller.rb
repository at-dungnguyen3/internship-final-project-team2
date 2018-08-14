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
      @picture = @product.pictures.build
    end

    def create
      @product = Product.new(product_params)
      respond_to do |format|
        if @product.save
          format.html { redirect_to admin_products_path, notice: 'Thêm sản phẩm thành công' }
        else
          format.html { render action: :new }
        end
      end
    end

    def edit; end

    def update
      respond_to do |format|
        if @product.update(product_params)
          format.html { redirect_to admin_products_path, notice: 'Cập nhập sản phẩm thành công' }
        else
          format.html { render action: :edit }
        end
      end
    end

    def destroy
      if @product.destroy
        flash[:success] = 'Xóa sản phẩm thành công'
      else
        flash[:danger] = 'Xóa sản phẩm thất bại'
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
  end
end
