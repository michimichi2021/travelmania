class Admin::AreasController < ApplicationController
before_action :authenticate_admin!  
  
def index
  @areas = Area.page(params[:page]).per(10)
  @area = Area.new
end

def create
  @area = Area.new(area_params)
  if @area.save
    redirect_to admin_areas_path
  else
    @areas = Area.all
    render 'index'
  end
end

def edit
  @area = Area.find(params[:id])
end

def update
  @area = Area.find(params[:id])
  if @area.update(area_params)
    redirect_to admin_areas_path
  else
    render 'edit'
  end
end

def destroy
  @area = Area.find(params[:id])
  if @area.destroy
    redirect_to admin_areas_path
  else
    render 'index'
  end
end


private

def area_params
  params.require(:area).permit(:name)
end

end