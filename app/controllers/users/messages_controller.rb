module Users
  class MessagesController < ApplicationController
    before_action :authenticate_user_or_photographer
    before_action :set_request, only: %i[index create]
    before_action :set_messages, only: [:index]


    def create
      @message = @request.messages.new(message_params)
      @message.user_id = current_user.id
      @message.photographer_id = @request.photographer_id
      @message.from = Message.froms[:user]

      if @message.save
        redirect_to user_request_messages_path(current_user, @request), notice: 'メッセージを送信しました'
      else
        render :index, notice: 'メッセージの送信に失敗しました'
      end
    end


    def index
      @message = Message.new
    end

    private

    def set_messages
      @messages = @request.messages.order(created_at: :desc)
    end

    def set_request
      @request = Request.find(params[:request_id])
    end

    def authenticate_user_or_photographer
      unless user_signed_in? || photographer_signed_in?
        redirect_to new_user_session_path, alert: 'ログインしてください'
      end
    end

    def message_params
      params.require(:message).permit(:content, :request_id, :from)
    end

  end
end
