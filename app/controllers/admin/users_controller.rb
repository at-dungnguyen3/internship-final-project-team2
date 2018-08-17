# frozen_string_literal: true

module Admin
  class UsersController < AdminController
    before_action :find_user, except: %i[index new create]
    after_action :activated, only: :create
    def index
      @users = User.search(params[:term]).paginate(page: params[:page], per_page: 10)
    end

    def show; end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      respond_to do |format|
        if @user.save
          format.html { redirect_to admin_users_path, notice: 'Thêm tài khoản thành công' }
        else
          format.html { render :new }
        end
      end
    end

    def edit; end

    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to admin_users_path, notice: 'Cập nhập tài khoản thành công' }
        else
          format.html { render :edit }
        end
      end
    end

    def destroy
      respond_to do |format|
        if @user.destroy
          format.html { redirect_to admin_users_path, notice: 'Xóa thành công' }
        else
          format.html { redirect_to admin_users_path, notice: 'Xóa không thành công' }
        end
      end
    end

    private

      def user_params
        params.require(:user).permit(%i[first_name last_name password password_confirmation email role])
      end

      def find_user
        (@user = User.find_by(id: params[:id])) or not_found
      end

      def activated
        @user.activate
      end
  end
end
