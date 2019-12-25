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
    if cart_params.present?
      @cart_num = CartItem.find(params[:id])
      @cart_num.update(cart_params)
      redirect_to cart_items_path(current_user)
    else
      @cart_items = current_user.cart_items.all
      if date_params[:delivery_date].present?
        if date_params[:delivery_date] > Time.current.since(2.days) && date_params[:delivery_date] < Time.current.next_month
          @cart_items.update(date_params)
          flash[:notice] = "配送時間変更完了"
          redirect_to cart_items_path(current_user)
        else
          flash[:notice] = "配送日は、本日から2日後から1ヶ月以内にしてください。"
          redirect_to cart_items_path(current_user)
        end
      else
        flash[:notice] = "配送日時を選択してください。"
        redirect_to cart_items_path(current_user)
      end
    end
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
    # 宅配時間がvalidatesと一致しているか検証
    @cart_items.each do |cart_item|
      if cart_item.delivery_date.nil? || cart_item.delivery_zone.nil?
        redirect_to cart_items_path(current_user), :notice => "申し訳ござません。宅配時間が設定されておりません、お手数をおかけしますが宅配時間を設定し直してください。" and return
      elsif cart_item.delivery_date < Time.current.since(2.days) || cart_item.delivery_date > Time.current.next_month
        redirect_to cart_items_path(current_user), :notice => "申し訳ござません。宅配時間が間違っております。本日から２日後から1ヶ月以内に設定してください。" and return
      else
      end
    end

    Payjp.api_key = 'sk_test_215ed6c716c8280b40d237d9'
    charge = Payjp::Charge.create(
    :amount => @total_price,
    :description => current_user.id,
    :card => params['payjp-token'],
    :currency => 'jpy',
    )
    # 購入処理が終わったら全てのcart_item上の商品の在庫を購入数減らす
    @cart_items.each do |cart_item|
      "transaction処理（購入したものを無効にする）を実装" unless cart_item.product.stock >= cart_item.num
    end
    @order_id = charge.id
    @cart_items.each do |cart_item|
      @after_stock = cart_item.product.stock - cart_item.num
      cart_item.product.update_attributes(stock: @after_stock)
      cart_item.destroy
      ProductPurchase.create(user_id: cart_item.user_id, product_id: cart_item.product_id, num: cart_item.num, order_id: @order_id, shipping_zip_code: cart_item.user.zip_code, shipping_prefectures: cart_item.user.prefectures, shipping_address: cart_item.user.address, delivery_date: cart_item.delivery_date_before_type_cast, delivery_zone: cart_item.delivery_zone_before_type_cast)
    end
    @cart_ids = CartItem.all.map {|cart_id| cart_id.id}
    PurchaseMailer.creation_email(@cart_ids).deliver_later
  end

  private

    def cart_params
      params.require(:cart_item).permit(:product_id, :user_id, :num)
    end

    def date_params
      params.require(:cart_item).permit(:delivery_date, :delivery_zone)
    end
end
