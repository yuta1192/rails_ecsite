class Admin::StockManagementsController < ApplicationController
  def management
    @products = Product.all
    if params[:stock_blank].present?
      if params[:stock_blank] == "true"
        @products = Product.stock_blank.search(params[:name])
      elsif params[:stock_blank] == "false"
        @products = Product.stock_present.search(params[:name])
      else
        @products = Product.all
      end
    end
  end

  def stock_updates
    a = params[:num].zip(params[:product_id])
    a.each do |b|
      if b.first.present?
        stock_update_num = b.first.to_i
        product_id = b.second.to_i
        stock = Product.find(product_id).stock + stock_update_num
        Product.find(product_id).update(stock: stock)
        Product.find(product_id).stock_updates.create(num: stock_update_num)
      end
    end
    redirect_to management_admin_stock_managements_path
  end
end
