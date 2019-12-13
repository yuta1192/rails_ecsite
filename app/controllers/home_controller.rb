class HomeController < ApplicationController
  def index
    @products = Product.all
    @kinds = @products.all.pluck(:kind).uniq
    @designers = @products.all.pluck(:designer).uniq
    @all_ranks = Product.find(Favorite.group(:product_id).order('count(product_id) desc').limit(15).pluck(:product_id))
  end

  def connect
  end

  def sitemap
  end
end
