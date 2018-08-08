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
end
