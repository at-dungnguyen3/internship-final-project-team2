# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :find_product, only: :show

  def show; end

  private

    def find_product
      (@product = Product.find_by(id: params[:id])) or not_found
    end
end
