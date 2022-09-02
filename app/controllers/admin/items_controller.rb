class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def create
    @item = Item.new(item_params)
    @items = Item.all
    if @item.save
      redirect_to admin_item_path(@item)
    else
      render :index
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  def new
    @item = Item.new
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :image, :introduction, :price, :is_active)
  end

end
