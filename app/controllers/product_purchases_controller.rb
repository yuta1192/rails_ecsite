class ProductPurchasesController < ApplicationController
  def index
    @product_purchases = current_user.product_purchases.all.order(created_at: :desc)
  end

  def show
    @product_purchase = current_user.product_purchases.find(params[:id])
  end

  def update
    @product_purchase = ProductPurchase.where(order_id: params[:order_id])
    if @product_purchase.update(address_params)
      flash[:success] = "update"
      redirect_to admin_order_path(@product_purchase.first.order_id)
    else
      flash[:danger] = "error"
      redirect_to admin_order_path(@product_purchase.first.order_id)
    end
  end

    private

    def address_params
      params.require(:product_purchase).permit(:shipping_zip_code, :shipping_prefectures, :shipping_address)
    end
end
