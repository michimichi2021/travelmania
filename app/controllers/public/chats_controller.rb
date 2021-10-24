class Public::ChatsController < ApplicationController
  before_action :follow_each_other, only: [:show]
  
  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    unless user_rooms.nil?
      @room = user_rooms.room
    else
      @room = Room.new
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end
    @chats = @room.chats.order('id DESC')
    @chat = Chat.new(room_id: @room.id,user_id: current_user.id)
   
  end
  
  def index
    @user_rooms = UserRoom.all
  end
  
  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save!
    redirect_to request.referer
  end
  
  def destroy
    Chat.find_by(id: params[:id]).destroy
    redirect_to request.referer
  end
  

  private
  
  def chat_params
    params.require(:chat).permit(:message, :room_id, :user_id)
  end
  
  def follow_each_other
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to user_path(user)
    end
  end
   
end