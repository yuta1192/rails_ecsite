class Admin::ProductsController < ApplicationController
  before_action :user_login, :user_admin
  include Admin::ProductsHelper

  def search
    if params[:commit] == "全て昇順▲"
      @products_search = Product.search(params[:search]).order(name: :asc).description(params[:description]).order(description: :asc).price_zone(params[:from],params[:to]).order(price: :asc).select_kind(params[:kind]).page(params[:page])
    elsif params[:commit] == "名前昇順▲"
      @products_search = Product.search(params[:search]).order(name: :asc).description(params[:description]).price_zone(params[:from],params[:to]).select_kind(params[:kind]).page(params[:page])
    elsif params[:commit] == "詳細昇順▲"
      @products_search = Product.search(params[:search]).description(params[:description]).order(description: :asc).price_zone(params[:from],params[:to]).select_kind(params[:kind]).page(params[:page])
    elsif params[:commit] == "値段昇順▲"
      @products_search = Product.search(params[:search]).description(params[:description]).price_zone(params[:from],params[:to]).order(price: :asc).select_kind(params[:kind]).page(params[:page])
    else
      @products_search = Product.search(params[:search]).description(params[:description]).price_zone(params[:from],params[:to]).select_kind(params[:kind]).page(params[:page]).per(24).order(sort_column + ' ' + sort_direction)
    end
    if params[:from].present? && params[:to].present?
      if params[:from] > params[:to]
        redirect_to search_admin_products_path, notice: "error:下限が上限を上回っています"
      end
    end
  end

  def index
    @products = Product.search(params[:search]).page(params[:page]).per(15)
    #@product_search = Product.search(params[:search]).order('name').page(params[:page]).per(50)
    @product_search = Product.search(params[:search]).page(params[:page]).per(48).order(sort_column + ' ' + sort_direction)
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
    params.require(:product).permit(:name, :description, :price, :kind, :image, :stock, :designer, :sale, :size)
  end
end
