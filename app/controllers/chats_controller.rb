class ChatsController < ApplicationController
  def index
    @users = User.all
    @chats = Chat.all
  end

  def create
    if Chat.between(params[:sender_id],params[:recipient_id]).present?
      @chat = Chat.between(params[:sender_id], params[:recipient_id]).first
    else
      @chat = Chat.create!(chat_parms)
    end
    redirect_to chat_messages_path(@chat)
  end

private
  def chat_parms
    params.permit(:sender_id, :recipient_id)
  end
end
