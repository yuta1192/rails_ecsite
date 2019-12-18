class ProductPurchasesController < ApplicationController
  def index
    @product_purchases = current_user.product_purchases.all.order(created_at: :desc)
  end

  def show
    @product_purchase = current_user.product_purchases.find(params[:id])
  end

  def update
    @product_purchase = User.find(params[:user_id]).product_purchases.find(params[:id])
    if @product_purchas.update(num_params)
      flash[:success] = "update"
      redirect_to admin_order_path(id: params[:id])
    else
      flash[:danger] = "error"
      redirect_to admin_order_path(id: params[:id])
    end
  end

    private

    def num_params
      params.require(:product_purchase).permit(:num)
    end
end
