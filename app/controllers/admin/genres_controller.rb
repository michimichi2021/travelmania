class Admin::GenresController < ApplicationController
before_action :authenticate_admin!  
  
def index
  @genres = Genre.all
  @genre = Genre.new
end

def create
  @area = Area.new(genre_params)
  if @area.save
    redirect_to admin_genres_path
  else
    render 'index'
  end
  
  @genre = Genre.new(genre_params)
  if @genre.save
    redirect_to admin_genres_path
  else
    render 'index'
  end
  
  @scene = Scene.new(genre_params)
  if @scene.save
    redirect_to admin_genres_path
  else
    render 'index'
  end
end

def edit
end

def update
end
 
  
end