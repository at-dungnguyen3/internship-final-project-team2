# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    @products = Product.is_online
  end
end
