class Admin::ItemsController < ApplicationController
  def index
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
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
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end

  def edit
    @item = Item.find(params[:id])
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item)
    else
      render :edit
    end
  end

  def new
    @item = Item.new
    @genres = Genre.all
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :image, :introduction, :price, :is_active)
  end

end
