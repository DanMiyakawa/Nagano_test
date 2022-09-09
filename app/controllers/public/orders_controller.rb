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
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end

  def new
    @order = Order.new
    @shipping_address = current_customer.shipping_address
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end

  def confirm
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
    @cart_items = CartItem.where(customer_id: current_customer.id)
    customer = current_customer
    select_address = params[:order][:select_address].to_i
    if select_address == 0
      @order = Order.new(order_params)
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif select_address == 1
      @order = Order.new(order_params)
      @address = ShippingAddress.find(params[:order][:address_id])
      @order.postal_code = @address.shipping_postal_code
      @order.address = @address.shipping_address
      @order.name = @address.shipping_name
    elsif select_address == 2
      @order = Order.new(order_params)
    else
    end
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.shipping_cost = 800
    if @order.save
      @cart_items = CartItem.where(customer_id: current_customer.id)
      @cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.item_id = cart_item.item_id
        order_detail.order_id = @order.id
        order_detail.amount = cart_item.amount
        order_detail.price = @total_billing_amount
        order_detail.save
      end
        @cart_items.destroy_all
        redirect_to public_orders_thanks_path
    end
  end

  def show
    @order = Order.find(params[:id])
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end

  def thanks
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end

  private

  def order_params
    params.require(:order).permit(:shipping_postal_code, :shipping_address, :shipping_name, :payment_method, :total_payment, :postal_code, :address, :name)
  end

end
