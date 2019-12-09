class ProductsController < ApplicationController
  def index
    @products = Product.order('name').page(params[:page]).per(9)
    @search_count = Product.search(params[:search]).count
    @counts = @search_count.zero? ? "見つかりませんでした。" : @search_count
    @favorite = Favorite.new
  end

  def show
    @product = Product.find(params[:id])
    @cart_add = CartItem.new
    @cart_item = CartItem.where(user_id: current_user, product_id: @product.id)
    @relation_products = Product.where(kind: @product.kind).order("RANDOM()").limit(3)
    @comments = Comment.where(product_id: @product.id)
    @favorite = Favorite.new
  end

  def search
    @products = Product.search(params[:search]).page(params[:page]).per(15)
    @product_search = Product.search(params[:search]).order('name').select_kind(params[:kind]).page(params[:page]).per(15)
    @search_count = Product.search(params[:search]).select_kind(params[:kind]).count
    @counts = @search_count.zero? ? "見つかりませんでした。" : @search_count
    @price_high = @products.price_high
    @price_low = @products.price_low
    @latest = @products.latest
    @oldest = @products.oldest
    @favorite_count = Product.find(Favorite.group(:product_id).order('count(product_id) desc').pluck(:product_id))
    @favorite = Favorite.new
  end
end
