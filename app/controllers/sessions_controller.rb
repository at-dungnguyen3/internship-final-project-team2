# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      check_active user
    else
      flash.now[:danger] = 'Sai tài khoản hoặc mật khẩu'
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

    def remember_status(user)
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
    end

    def check_active(user)
      if user.activated?
        log_in user
        remember_status user
        redirect_back_or user
      else
        flash[:warning] = 'Tài khoản chưa được kích hoạt'
        redirect_to root_path
      end
    end
end
