class Admin::GenresController < ApplicationController
  def index
    @genre = Genre.new
    @genres = Genre.all
  end
  
  def create
    @genre = Genre.new
    if @genre .save
      redirect_to 
  end

  def edit
  end
  
  def update
  end
  
end
