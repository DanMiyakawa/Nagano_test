class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    if @order_detail.update(making_status_params)
      if @order.order_details.any?{|order_detail| order_detail.making_status == "製作中"}
        @order.update(order_status: "製作中")
      end
      if @order.order_details.all?{|order_detail| order_detail.making_status == "製作完了"}
        @order.update(order_status: "発送準備中")
      end
      redirect_to admin_order_path(@order_detail.order)
    else
      render admin_order_path
    end
  end

  private

  def making_status_params
    params.require(:order_detail).permit(:making_status)
  end
end
