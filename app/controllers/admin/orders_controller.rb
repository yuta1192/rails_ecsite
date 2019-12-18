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
    @stock = num_params[:num].to_i - @product_purchase.num
    if @product_purchase.update(num_params)
      @product_stock = @product_purchase.product.stock - @stock
      @product_purchase.product.update(stock: @product_stock)
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
