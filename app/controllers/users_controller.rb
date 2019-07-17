class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "welcome"
      redirect_to @user
    else
      render 'new'
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
