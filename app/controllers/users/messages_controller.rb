module Users
  class MessagesController < ::MessagesController
    include Authorizer
    before_action :correct_user!
    before_action :set_request, only: %i[index create]
    before_action :check_status, only: %i[create index]
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
      @request = current_user.requests.find(params[:request_id])
      unless @request && @request.accessed_by?(current_user, current_photographer)
        redirect_to requests_path, alert: 'アクセスが許可されていません'
      end
    end

    def message_params
      params.require(:message).permit(:content, :request_id, :from)
    end
  end
end
