# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

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
    flash[:danger] = 'Xin vui lòng đăng nhập tài khoản'
    redirect_to login_url
  end
end
