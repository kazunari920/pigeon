class MessagesController < ApplicationController
  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      redirect_to @message.request, notice: 'メッセージの作成に成功しました'
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:request_id, :content)
  end
end
