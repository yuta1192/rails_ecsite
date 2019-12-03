class Admin::ProductsController < ApplicationController
  before_action :user_login, :user_admin

  def search
    @products_search = Product.search(params[:search]).description(params[:description]).price_zone(params[:from],params[:to])
  end

  def index
    @products = Product.search(params[:search]).page(params[:page]).per(15)
    @product_search = Product.search(params[:search]).order('name').page(params[:page]).per(15)
  end

  def new
    @product = Product.new
  end

  def show
    @product = Product.find(params[:id])
    @relation_products = Product.where(kind: @product.kind).order("RANDOM()").limit(3)
    @comments = Comment.where(product_id: @product.id)
    @favorite = Favorite.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product
    else
      render 'new'
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      flash[:success] = "updaaaaaaaaaaate!!"
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path, notice: "ユーザー「#{@product.name}」を削除しました。"
  end

  private

  def user_login
    redirect_to root_path unless logged_in?
  end

  def user_admin
    redirect_to root_path unless current_user.admin?
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :kind, :image)
  end

  def admin_products_search

  end
end
