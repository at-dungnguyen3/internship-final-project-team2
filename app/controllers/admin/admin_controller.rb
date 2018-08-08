# frozen_string_literal: true

module Admin
  class AdminController < ApplicationController
    before_action :logged_in_user
    before_action :check_admin

    layout 'admin'

    private

      def check_admin
        return if current_user.admin?
        flash[:danger] = 'Bạn không có quyền truy cập'
        redirect_to root_url
      end
  end
end
