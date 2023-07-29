module Photographers
  class MessagesController < ApplicationController
    before_action :authenticate_user_or_photographer
    before_action :correct_photographer!
    before_action :set_request, only: %i[create index]
    before_action :check_status, only: %i[create index]
    before_action :set_messages, only: %i[index]

    def create
      @message = @request.messages.new(message_params)
      @message.user_id = @request.user_id
      @message.photographer_id = current_photographer.id
      @message.from = Message.froms[:photographer]

      if @message.save
        redirect_to photographer_request_messages_path(current_photographer, @request), notice: 'メッセージを送信しました'
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
      @request = current_photographer.find_request(params[:request_id])
      unless @request && @request.accessed_by?(current_user, current_photographer)
        redirect_to requests_path, alert: 'アクセスが許可されていません'
      end
    end

    def message_params
      params.require(:message).permit(:content, :request_id, :from)
    end

    def authenticate_user_or_photographer
      unless user_signed_in? || photographer_signed_in?
        redirect_to new_user_session_path, alert: 'ログインしてください'
      end
    end

    def check_status
      if @request.pending?
        flash[:error] = 'このリクエストは承認されていません'
        redirect_to requests_path
      elsif @request.completed?
        flash[:error] = 'このリクエストは閉じられました'
        redirect_to requests_path
      end
    end
  end
end
