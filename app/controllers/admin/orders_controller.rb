class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end

    def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    if @order.update(order_status_params)
      if @order.order_status == "入金待ち"
        @order_details.update_all(making_status: "着手不可")
      elsif @order.order_status == "入金確認"
        @order_details.update_all(making_status: "製作待ち")
      end
      redirect_to request.referer
    else
      render admin_order_path(@order)
    end
  end

private

  def order_status_params
    params.require(:order).permit(:order_status)
  end

end
