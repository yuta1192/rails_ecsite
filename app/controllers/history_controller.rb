class HistoryController < ApplicationController
  def index
    @product_purchases = current_user.product_purchases.all.order(created_at: :desc)
  end
  def specification
    @product_purchase = current_user.product_purchase.find(params[:id])
  end
end
