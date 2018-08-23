# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :load_categories

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  rescue StandardError
    render_404
  end

  def render_404
    render file: "#{Rails.root}/public/404", status: :not_found
  end

  def logged_in_user
    return if logged_in?
    store_location
    redirect_to login_url
  end

  private

    def load_categories
      @categories = Category.is_parent
    end
end
