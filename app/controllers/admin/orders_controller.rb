class Admin::OrdersController < ApplicationController
  def index
    @orders = ProductPurchase.all.pluck(:order_id).uniq.compact
    @product_purchases_search = ProductPurchase.where(finish_flag: false).search(params[:order_id]).uniq(&:order_id)

    respond_to do |format|
      format.html
      format.csv { send_data @product_purchases.generate_csv, filename: "orders-#{Time.zone.now.strftime('%Y%m%d%S')}.csv" }
    end
  end

  def import
    ProductPurchase.import(params[:file])
    redirect_to admin_orders_path
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

  def delivery_update
    if date_params[:delivery_date].present? && date_params[:delivery_zone].present?
      @product_purchase = ProductPurchase.where(order_id: params[:order_id])
      if date_params[:delivery_date] > Time.current.since(2.days) && date_params[:delivery_date] < Time.current.next_month
        @product_purchase.update(date_params)
        flash[:notice] = "配送時間変更完了"
        redirect_to admin_order_path(params[:order_id])
      else
        flash[:notice] = "配送日は、本日から2日後から1ヶ月以内にしてください。"
        redirect_to admin_order_path(params[:order_id])
      end
    else
      flash[:notice] = "配送日時を選択してください。"
      redirect_to admin_order_path(params[:order_id])
    end
  end

  def deliverynote
    @orders = ProductPurchase.where(order_id: params[:order_id])
    @total_price = 0
    @orders.each do |order|
      @total_price += order.product.price * order.num
    end
  end

  def finish_flag
    if params.dig(:product_purchase, :finish_flag) == "true"
      ProductPurchase.where(order_id: params[:order_id]).update(finish_flag: true)
      flash[:notice] = "選択した受注を終了しました。"
      redirect_to admin_orders_path
    else
      flash[:notice] = "エラー"
      redirect_to admin_orders_path
    end
  end

    private

    def num_params
      params.require(:product_purchase).permit(:num)
    end

    def date_params
      params.require(:product_purchase).permit(:delivery_date, :delivery_zone)
    end
end
