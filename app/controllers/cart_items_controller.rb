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
    @cart_items = current_user.cart_items.all
    @total_price = 0
    @cart_items.each do |cart_item|
      @total_price += (cart_item.product.price*cart_item.num)
    end
    # 在庫と購入数が一致しているか検証
    @cart_items.each do |cart_item|
      if cart_item.product.stock >= cart_item.num
      else
        redirect_to cart_items_path(current_user), :notice => "#{cart_item.product.name}は在庫数#{cart_item.product.stock}以上は購入できません！" and return
      end
    end

    Payjp.api_key = 'sk_test_215ed6c716c8280b40d237d9'
    charge = Payjp::Charge.create(
    :amount => @total_price,
    :card => params['payjp-token'],
    :currency => 'jpy',
    )
    # 購入処理が終わったら全てのcart_item上の商品の在庫を購入数減らす
    @cart_items.each do |cart_item|
      @after_stock = cart_item.product.stock - cart_item.num
      cart_item.product.update_attributes(stock: @after_stock)
    end
  end

  private

    def cart_params
      params.require(:cart_item).permit(:id, :product_id, :user_id, :num)
    end
end
