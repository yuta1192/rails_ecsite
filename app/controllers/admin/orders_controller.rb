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
    @product_purchase = ProductPurchase.find(params[:id])
    if @product_purchase.update(num_params)
      flash[:success] = "update"
      redirect_to admin_order_path(@product_purchase.order_id)
    else
      flash[:danger] = "error"
      redirect_to admin_order_path(id: params[:id])
    end
  end

  def destroy
  end

    private

    def num_params
      params.require(:product_purchase).permit(:num)
    end
end
