class Admin::ScenesController < ApplicationController
before_action :authenticate_admin!  
  
def index
  @scenes = Scene.all
  @scene = Scene.new
end

def create
  @scene = Scene.new(scene_params)
  if @scene.save
    redirect_to admin_scenes_path
  else
    @scenes = Scene.all
    render 'index'
  end
end

def edit
  @scene = Scene.find(params[:id])
end

def update
  @scene = Scene.find(params[:id])
  if @scene.update(scene_params)
    redirect_to admin_scenes_path
  else
    render 'edit'
  end
end

def destroy
  @scene = Scene.find(params[:id])
  if @scene.destroy
    redirect_to admin_scenes_path
  else
    render 'index'
  end
end

private

def scene_params
  params.require(:scene).permit(:name)
end

  
end