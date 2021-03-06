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
    @relation_products = Product.where(kind: @product.kind).order("RANDOM()").limit(6)
    @comments = Comment.where(product_id: @product.id)
    @favorite = Favorite.new
    @num = 1..@product.stock
    @max_num = @num.to_a
  end

  def search
    @products = Product.search(params[:search]).page(params[:page]).per(18)
    @product_search = Product.search(params[:search]).order('name').select_kind(params[:kind]).who_desiner(params[:designer]).select_size(params[:size]).is_sale?(params[:sale]).price_zone(params[:from],params[:to]).stock_valid?(params[:valid]).page(params[:page]).per(18)
    @search_count = Product.search(params[:search]).select_kind(params[:kind]).who_desiner(params[:designer]).select_size(params[:size]).is_sale?(params[:sale]).price_zone(params[:from],params[:to]).stock_valid?(params[:valid]).count
    @counts = @search_count.zero? ? "0" : @search_count
    @price_high = @products.price_high
    @price_low = @products.price_low
    @latest = @products.latest
    @oldest = @products.oldest
    @favorite_count = Product.find(Favorite.group(:product_id).order('count(product_id) desc').pluck(:product_id))
    @favorite = Favorite.new
  end
end
