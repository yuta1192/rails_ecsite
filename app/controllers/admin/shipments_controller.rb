class Admin::ShipmentsController < ApplicationController
  def index
    @product_purchases_search = ProductPurchase.where(finish_flag: true).search(params[:order_id]).uniq(&:order_id)
  end
end
