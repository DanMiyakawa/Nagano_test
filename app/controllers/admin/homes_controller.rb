class Admin::HomesController < ApplicationController
  def top
    @params = params[:id]
    @order = Order.all
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end
end
