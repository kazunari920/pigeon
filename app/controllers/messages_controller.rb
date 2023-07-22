class MessagesController < ApplicationController
  before_action :set_request
  before_action :authenticate_user_or_photographer

  def create
    @message = Message.new(message_params)
    @message.request = @request

    if current_user
      @message.messageable = current_user
      @message.recipient = @request.photographer
    else
      @message.messageable = current_photographer
      @message.recipient = @request.user
    end

    if @message.save
      redirect_to @request, notice: 'メッセージを送信しました'
    else
      render :new
    end
  end

def show
  @messages = @request.messages.order(created_at: :asc)
  @message = Message.new
end

  private

  def set_request
    @request = Request.find(params[:request_id])
  end

  def authenticate_user_or_photographer
    unless user_signed_in? || photographer_signed_in?
      redirect_to new_user_session_path, alert: 'ログインしてください'
    end
  end


  def message_params
    params.require(:message).permit(:request_id, :content)
  end
end