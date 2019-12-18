class CartItemsController < ApplicationController
  def show
  end

  def history
    @product_purchases = current_user.product_purchases.all.order(created_at: :desc)
  end

  def confirmation
    @cart_items = current_user.cart_items.all
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
        cart_item.update_attributes(num: cart_item.product.stock)
        redirect_to cart_items_path(current_user), :notice => "申し訳ござません。選択された注文は、この商品の最大注文数量を超過しています。カート内の数量が最大注文数量に変更されました" and return
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
      "transaction処理（購入したものを無効にする）を実装" unless cart_item.product.stock >= cart_item.num
    end
    @order_id = Payjp::Charge.all.first.id
    @cart_items.each do |cart_item|
      @after_stock = cart_item.product.stock - cart_item.num
      cart_item.product.update_attributes(stock: @after_stock)
      cart_item.destroy
      ProductPurchase.create(user_id: cart_item.user_id, product_id: cart_item.product_id, num: cart_item.num, order_id: @order_id, shipping_zip_code: cart_item.user.zip_code, shipping_prefectures: cart_item.user.prefectures, shipping_address: cart_item.user.address)
    end
    @cart_ids = CartItem.all.map {|cart_id| cart_id.id}
    PurchaseMailer.creation_email(@cart_ids).deliver_later
  end

  private

    def cart_params
      params.require(:cart_item).permit(:product_id, :user_id, :num)
    end

    def purchase_params
      params.require(:product_purchase).permit()
    end
end
