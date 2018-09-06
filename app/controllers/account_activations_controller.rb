# frozen_string_literal: true

class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      flash[:success] = 'Kích hoạt tài khoản thành công'
      redirect_to user
    else
      flash[:danger] = 'Invalid activation link'
      redirect_to root_url
    end
  end
end
