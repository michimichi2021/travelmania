class Public::CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = @post.id
    @comments = @post.comments
    @comment_post = @comment.post
    @comment.save
    @comment_post.create_notification_comment!(current_user, @comment.id)
    redirect_to post_path(@post)
  end 

  def destroy
    Comment.find_by(id: params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :user_id, :post_id)
  end

end