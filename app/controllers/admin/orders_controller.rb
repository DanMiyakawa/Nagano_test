class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_status_params)
      redirect_to request.referer
    else
      render admin_order_path(@order)
    end
  end

  def order_status_params
    params.require(:order).permit(:order_status)
  end

end
