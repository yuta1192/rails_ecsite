class Admin::UsersController < ApplicationController
  before_action :user_login, :user_admin

  def index
    @users = User.all

    respond_to do |format|
      format.html
      format.csv { send_data @users.generate_csv, filename: "users-#{Time.zone.now.strftime('%Y%m%d%S')}.csv" }
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(admin_user_params)
    if @user.save
      flash[:success] = "管理ユーザーを作成しました。"
      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を削除しました。"
  end

  private

  def user_login
    redirect_to root_path unless logged_in?
  end

  def user_admin
    redirect_to root_path unless current_user.admin?
  end

  def admin_user_params
    params.require(:user).permit(:name, :sex, :birthday, :email, :address, :tel, :password, :password_confirmation, :prefectures, :zip_code, :admin)
  end
end
