class Public::HomesController < ApplicationController
  def top
    @items = Item.all
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end

  def about
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end
end
