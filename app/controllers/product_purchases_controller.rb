class ProductPurchasesController < ApplicationController
  def index
    @product_purchases = current_user.product_purchases.all.order(created_at: :desc)
  end
  def show
    @product_purchase = current_user.product_purchases.find(params[:id])
  end
end
