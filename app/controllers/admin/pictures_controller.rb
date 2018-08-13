# frozen_string_literal: true

module Admin
  class PicturesController < AdminController
    before_action :find_picture

    def edit; end

    def update
      respond_to do |format|
        format.html { redirect_to admin_product_url(@picture.product.id), notice: 'Cập nhập hình ảnh thành công' } if @picture.update(picture_params)
      end
    end

    def destroy
      respond_to do |format|
        format.html { redirect_to admin_product_url(@picture.product.id), notice: 'Xóa ảnh thành công' } if @picture.destroy
      end
    end

    private

      def picture_params
        params.require(:picture).permit(:image)
      end

      def find_picture
        (@picture = Picture.find_by(id: params[:id])) || not_found
      end
  end
end
