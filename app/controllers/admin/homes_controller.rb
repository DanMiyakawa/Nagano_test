class Admin::HomesController < ApplicationController
  def top
    @params = params[:id]
    @order = Order.all
  end
end
