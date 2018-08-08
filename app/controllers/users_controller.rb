# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :find_user, except: %i[index new create]

  def index; end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = 'Please check your email to activate your account.'
      redirect_to root_url
    else
      flash.now[:danger] = 'Đăng ký không thành công'
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

    def find_user
      (@user = User.find_by(id: params[:id])) || not_found
    end
end
