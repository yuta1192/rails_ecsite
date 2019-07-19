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

  def destroy
  end

  def favorite
  end

  def cart
  end

    private

    def user_params
      params.require(:user).permit(:name, :email, :address, :tel, :password, :password_confirmation)
    end
end
