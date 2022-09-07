class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end
  
  def order_params
    params.require(:order).permit(:shipping_postal_code, :shipping_address, :shipping_name, :payment_method, :total_payment, :postal_code, :address, :name)
  end
  
end
