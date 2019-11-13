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
    @product_search = Product.search(params[:search]).order('name').page(params[:page]).per(15)
    @search_count = Product.search(params[:search]).count
    @counts = @search_count.zero? ? "見つかりませんでした。" : @search_count
    @price_high = @products.order(price: "desc")
    @price_low = @products.order(price: "asc")
    @latest = @products.order(created_at: "desc")
    @oldest = @products.order(created_at: "asc")
    @favorite_count = Product.find(Favorite.group(:product_id).order('count(product_id) desc').pluck(:product_id))
    @favorite = Favorite.new
  end
end
