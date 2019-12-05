class Admin::UsersController < ApplicationController
  before_action :user_login, :user_admin

  def index
    @users = User.all

    respond_to do |format|
      format.html
      format.csv { send_data @users.generate_csv, filename: "users-#{Time.zone.now.strftime('%Y%m%d%S')}.csv" }
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
end
