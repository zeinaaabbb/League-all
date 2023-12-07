class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    @selected_tab = params[:tab]
    # raise
  end
end
