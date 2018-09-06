# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[show edit update]
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
      flash[:info] = 'Vui lòng kiểm trả email để kích hoạt tài khoản'
      redirect_to root_url
    else
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
