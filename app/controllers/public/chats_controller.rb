class Public::ChatsController < ApplicationController
  before_action :authenticate_user!
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
    @chats = @room.chats.order('id DESC').page(params[:page]).per(10)
    @chat = Chat.new(room_id: @room.id,user_id: current_user.id)
   
  end
  

  def create
    @chat = current_user.chats.new(chat_params)
    @room = @chat.room
    if @chat.save
    
    @roommembernotme=UserRoom.where(room_id: @room.id).where.not(user_id: current_user.id)
    @theid=@roommembernotme.find_by(room_id: @room.id)
   
    
    notification = current_user.active_notifications.new(
    chat_id: @chat.id,
    room_id: @room.id,
    visited_id: @theid.user_id,
    visiter_id: current_user.id,
    action: 'chat'
    )
    
    
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?

     
      
    redirect_to request.referer
    
    end
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
    @user = User.find(params[:id])
    unless current_user.following?(@user) && @user.following?(current_user)
      redirect_to user_path(current_user)
    end
  end
   
end