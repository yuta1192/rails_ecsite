class CartItemsController < ApplicationController
  def show
  end

  def index
    @cart_items = CartItem.all
    @total_price = 0
    @cart_items.each do |cart_item|
      @total_price += cart_item.product.price
    end
  end

  def create
    @cart_add = CartItem.create(cart_params)
  end

  def update
    @cart_num = CartItem.find(params[:id])
    @cart_num.update_attributes(cart_params)
    redirect_to cart_items_path(current_user)
  end

  private

    def cart_params
      params.require(:cart_item).permit(:product_id, :user_id, :num)
    end
end
