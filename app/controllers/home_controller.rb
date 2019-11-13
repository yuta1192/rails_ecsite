class HomeController < ApplicationController
  def index
    @all_ranks = Product.find(Favorite.group(:product_id).order('count(product_id) desc').limit(6).pluck(:product_id))
  end

  def connect
  end

  def sitemap
  end
end
