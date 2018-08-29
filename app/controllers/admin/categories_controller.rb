# frozen_string_literal: true

module Admin
  class CategoriesController < AdminController
    before_action :find_category, except: %i[index new create]

    def index
      @category = nil
      @categories = Category.search(params[:term]).paginate(page: params[:page], per_page: 10)
    end

    def show
      @categories = @category.childs.paginate(page: params[:page], per_page: 10)
      if @categories.any?
        render :index
      else
        redirect_to admin_categories_path
      end
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)
      if @category.check_parent? && @category.save
        flash[:success] = 'Thêm danh mục thành công'
        redirect_to admin_categories_path
      else
        flash[:danger] = 'Thêm danh mục không thành công'
        render :new
      end
    end

    def edit; end

    def update
      parent_cat = Category.find_by(id: params[:category][:categories_id])
      update =
        if parent_cat.nil? || (parent_cat && parent_cat.parent.nil? && ((@category.parent.nil? && @category.childs.empty?) || !@category.parent.nil?))
          @category.update(category_params)
        else
          @category.errors[:categories_id] << 'vượt quá số cấp cho phép'
          false
        end
      if update
        flash[:success] = 'Cập nhập danh mục thành công'
        redirect_to admin_categories_path
      else
        flash[:danger] = 'Cập nhập danh mục thất bại'
        render :edit
      end
    end

    def destroy
      cats = @category.childs.any? ? @category.childs.map(&:id) : @category.id
      products = Product.in_categories(cats).in_cart
      if products.any?
        flash[:warning] = 'Không thể xóa danh mục. Vẫn còn sản phẩm trong danh mục trong giỏ hàng chưa thanh toán'
      elsif @category.destroy
        flash[:success] = 'Xóa danh mục thành công'
      else
        flash[:danger] = 'Xóa danh mục thất bại'
      end
      redirect_to admin_categories_path
    end

    private

      def category_params
        params.require(:category).permit(:name, :categories_id, :term)
      end

      def find_category
        (@category = Category.find_by(id: params[:id])) || not_found
      end
  end
end
