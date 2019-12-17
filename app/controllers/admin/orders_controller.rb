class Admin::OrdersController < ApplicationController
  def index
    @orders = ProductPurchase.all.pluck(:order_id).uniq.compact
  end

  def show
    @orders = ProductPurchase.where(order_id: params[:id])
  end

  def edit
  end

  def new
  end

  def create
  end

  def update
  end

  def destroy
  end
end
