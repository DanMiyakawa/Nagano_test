class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end

  def show
    @customer = Customer.find(params[:id])
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end

  def edit
    @customer = Customer.find(params[:id])
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to admin_customer_path(@customer.id)
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :is_deleted)
  end

end
