class Public::OrdersController < ApplicationController

  before_action :cart_check, only: [:new, :confirm, :create]

  def cart_check
    unless CartItem.find_by(customer_id: current_customer.id)
      flash[:danger] = "カートに商品がない状態です"
      redirect_to root_url
    end
  end

  def index
    @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc)
  end

  def new
    @order = Order.new
    @shipping_address = current_customer.shipping_address
  end

  def confirm
  end

  def show
    @order = Order.find(params[:id])
  end

  def thanks
  end

  private

  def order_params
    params.require(:order).permit(:shipping_postcode, :shipping_address, :shipping_name, :total_payment, :payment_option)
  end

end
