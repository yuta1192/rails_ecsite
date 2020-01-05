class HomeController < ApplicationController
  def index
    @products = Product.all
    @kinds = @products.all.pluck(:kind).uniq
    @designers = @products.all.pluck(:designer).uniq
    @all_ranks = Product.find(Favorite.group(:product_id).order('count(product_id) desc').limit(15).pluck(:product_id))
    if current_user.present?
      if current_user.favorites.present?
        @favorite_product_kind = current_user.favorites.sample.product.kind
        @relation_products = Product.where(kind: @favorite_product_kind).order("RANDOM()").limit(5)
      end
    end
  end

  def connect
  end

  def sitemap
  end
end
