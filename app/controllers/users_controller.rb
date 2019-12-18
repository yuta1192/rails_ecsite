class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "welcome"
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "update"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def unsubscribed
    @user = current_user
  end

  def destroy
    @user = current_user
    if @user.destroy
      flash[:notice] = "退会しました。"
      redirect_to root_path
    else
      flash[:notice] = "失敗しました。"
      render 'show'
    end
  end

  def favorite
    @favorites = Favorite.where(user_id: current_user)
    @favorites_list = @favorites.order(created_at: "desc").page(params[:page]).per(15)
    @favorite_counts = @favorites.count
    @counts = @favorite_counts.zero? ? "0件です。" : @favorite_counts
    @cart_add = CartItem.new
  end

  def cart
  end

    private

    def user_params
      params.require(:user).permit(:name, :email, :address, :tel, :password, :password_confirmation, :prefectures, :zip_code)
    end
end
