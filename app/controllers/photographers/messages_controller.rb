module Photographers
  class MessagesController < ApplicationController

    def create
      @message = Message.new(message_params)
      @message.photographer_id = current_photographer.id
      @message.from = :photographer
      if @message.save
        redirect_to user_path(current_user), notice: 'メッセージを送信しました'
      else
        render :new
      end
    end

    private

    def message_params
      params.require(:message).permit(:body, :user_id, :request_id)
    end
  end
end