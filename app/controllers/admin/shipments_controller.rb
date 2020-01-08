class Admin::ShipmentsController < ApplicationController
  include Admin::ShipmentsHelper

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
    if params[:num].present?
      if params[:num] == "購入されたことがある"
        @product_id = ProductPurchase.all.uniq(&:product_id).pluck(:product_id)
        @products = Product.search(params[:name]).where(id: @product_id).order(sort_column + ' ' + sort_direction)
      elsif params[:num] == "購入されたことがない"
        @product_id = ProductPurchase.all.uniq(&:product_id).pluck(:product_id)
        @products = Product.search(params[:name]).where.not(id: @product_id).order(sort_column + ' ' + sort_direction)
      else
        @products = Product.search(params[:name]).order(sort_column + ' ' + sort_direction)
      end
    else
      @products = Product.search(params[:name]).order(sort_column + ' ' + sort_direction)
    end
    @num = ProductPurchase.where(product_id: @products).sum(:num).to_s
    @nums = []
    @nums << @num
    @product_id = ProductPurchase.where(product_id: @products).pluck(:product_id).uniq
    @product_name = Product.where(id: @product_id).pluck(:name)
    @csv = @product_name.product(@nums)

    respond_to do |format|
      format.html
      format.csv { send_data @csv.generate_csv, filename: "total_picking-#{Time.zone.now.strftime('%Y%m%d%S')}.csv" }
    end
  end

  def total_picking_products
    @product = Product.find(params[:id])
    @total_purchase_num = Product.find(params[:id]).product_purchases.sum(:num)
    @product_purchases = Product.find(params[:id]).product_purchases
  end
end
