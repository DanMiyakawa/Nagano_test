class Public::GenresController < ApplicationController
  def show
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @genreitems = Item.where(genre_id: @genre.id)
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end
end
