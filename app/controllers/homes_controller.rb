class HomesController < ApplicationController
  def top
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end
end
