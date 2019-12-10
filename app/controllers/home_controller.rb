class HomeController < ApplicationController
  def index
    @products = Product.all
    @kinds = @products.map{|product|[product.kind]}.uniq
    @all_ranks = Product.find(Favorite.group(:product_id).order('count(product_id) desc').limit(20).pluck(:product_id))
    @search_kind = Product.select_kind(params[:kind]).page(params[:page]).per(15)
  end

  def connect
  end

  def sitemap
  end
end
