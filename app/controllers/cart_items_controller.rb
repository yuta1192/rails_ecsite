class CartItemsController < ApplicationController
  def show
  end

  def index
    @user = User.find(params[:id])
    @carts = CartItem.all
    @cart_items = @user.cart_items.all
    @total_price = 0
    @cart_items.each do |cart_item|
      @total_price += (cart_item.product.price*cart_item.num)
    end
  end

  def create
    @cart_add = CartItem.create(cart_params)
    redirect_to cart_items_path(current_user)
  end

  def update
    @cart_num = CartItem.find(params[:id])
    @cart_num.update(cart_params)
    redirect_to cart_items_path(current_user)
  end

  def destroy
    CartItem.find(params[:id]).destroy
    redirect_to cart_items_path(current_user)
  end

  def pay
      Payjp.api_key = 'sk_test_215ed6c716c8280b40d237d9'
      charge = Payjp::Charge.create(
      :amount => @product.price,
      :card => params['payjp-token'],
      :currency => 'jpy',
  )
  end

  private

    def cart_params
      params.require(:cart_item).permit(:product_id, :user_id, :num)
    end
end
