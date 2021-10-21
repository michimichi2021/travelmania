class Public::UsersController < ApplicationController
before_action :authenticate_user!  

def show
  @user = User.find(params[:id])
  @posts = @user.posts

end

def edit
  @user = User.find(params[:id])
end

def update
  @user = User.find(params[:id])
  if @user.update(user_params)
    redirect_to user_path(@user)
  else
    render 'edit'
  end
end

def favorites
end

def follows
end

def followers
end

def unsubscribe
 @user = current_user
end

def withdraw
  @user = current_user
  @user.update(is_deleted: true)
  reset_session
  redirect_to root_path
end

private



def user_params
  params.require(:user).permit(:name, :email, :is_deleted, :image, :introduction)
end

end