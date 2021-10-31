class Public::PostsController < ApplicationController
before_action :search_product, only: [:search]
before_action :authenticate_user!,except:[:show, :search, :destroy]

def new
  @post = Post.new
end

def create
  @post = current_user.posts.new(post_params)

  if @post.save(post_params)
    redirect_to post_path(@post)
  else
    render 'new'
  end
end

def show
  @post = Post.find(params[:id])
  @user = @post.user
  @comment = Comment.new
  @comments = @post.comments
  @favorite = Favorite.new
end

def edit
  @post = Post.find(params[:id])
  if @post.user == current_user
    render :edit
  else
    redirect_to root_path
  end
end

def update
  @post = Post.find(params[:id])
  if @post.update(post_params)
    redirect_to post_path(@post)
  else
    render 'edit'
  end
end

def destroy
  @post = Post.find(params[:id])
  @user = @post.user
  @post.destroy
  redirect_to user_path(@user)
end

def search
  @results = @p.result.page(params[:page]).per(10)
  @posts = Post.page(params[:page]).per(20)
end

private

def search_product
  @p = Post.ransack(params[:q])
  @results = @p.result
end

def post_params
  params.require(:post).permit(:name, :introduction, :area_id, :genre_id, :scene_id, :image)
end

end