# frozen_string_literal: true

module Admin
  class PicturesController < AdminController
    before_action :find_picture

    def edit; end

    def update
      respond_to do |format|
        if @picture.update(picture_params)
          change_image_in_redis(@picture.product)
          format.html { redirect_to admin_product_url(@picture.product.id), flash: { success: 'Cập nhập hình ảnh thành công' } }
        end
      end
    end

    def destroy
      respond_to do |format|
        if @picture.destroy
          change_image_in_redis(@picture.product)
          format.html { redirect_to admin_product_url(@picture.product.id), flash: { success: 'Xóa ảnh thành công' } }
        end
      end
    end

    private

      def picture_params
        params.require(:picture).permit(:image)
      end

      def find_picture
        (@picture = Picture.find_by(id: params[:id])) || not_found
      end

      def change_image_in_redis(product)
        $redis.keys('*').each do |key|
          auction = JSON.parse($redis.get(key))
          if auction['product_id'] == product.id
            auction['product_pictures'] = product.pictures
            $redis.set(key, auction.to_json)
          end
        end
      end
  end
end
