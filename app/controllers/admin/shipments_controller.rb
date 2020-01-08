class Admin::ShipmentsController < ApplicationController
  def index
    if params[:status].present?
      @product_purchases_search = ProductPurchase.where(finished_flag: true, status: params[:status]).search(params[:order_id]).uniq(&:order_id)
    else
      @product_purchases_search = ProductPurchase.where(finished_flag: true).search(params[:order_id]).uniq(&:order_id)
    end
    @product_purchases =  ProductPurchase.where(finished_flag: true)

    respond_to do |format|
      format.html
      format.csv { send_data @product_purchases.generate_csv, filename: "shipments-#{Time.zone.now.strftime('%Y%m%d%S')}.csv" }
    end
  end

  def import
    ProductPurchase.import(params[:file])
    redirect_to admin_shipments_path
  end

  def home
  end

  def show
    @orders = ProductPurchase.where(order_id: params[:id])
  end

  def status
    if params[:product_purchase][:status] == "出荷可能"
      ProductPurchase.where(order_id: params[:order_id]).update(status: 0)
      flash[:notice] = "出荷状況を「出荷可能」に変更しました。"
      redirect_to admin_shipments_path
    elsif params[:product_purchase][:status] == "着手"
      ProductPurchase.where(order_id: params[:order_id]).update(status: 1)
      flash[:notice] = "出荷状況を「着手」に変更しました。"
      redirect_to admin_shipments_path
    else params[:product_purchase][:status] == "出荷済"
      ProductPurchase.where(order_id: params[:order_id]).update(status: 2)
      flash[:notice] = "出荷状況を「出荷済」に変更しました。"
      redirect_to admin_shipments_path
    end
  end

  def total_picking_list
    
  end
end
