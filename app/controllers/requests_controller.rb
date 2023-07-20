class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :update, :accept, :decline, :complete]

  def new
    @request = Request.new(photographer_id: params[:photographer_id])
  end

  def create
    @request = current_user.requests.build(request_params)
    if @request.save
      redirect_to user_requests_requests_path, notice: 'リクエストの作成に成功しました'
    else
      render :new
    end
  end

  def show
    @messages = @request.messages.order(created_at: :asc)
    @message = Message.new
  end

  def update
    if @request.update(request_params)
      redirect_to @request, notice: 'リクエストの更新に成功しました'
    else
      render :edit
    end
  end

  def index
    @requests = current_photographer.requests
  end

  def user_requests
    @requests = current_user.requests
  end

  def accept
    @request.accepted!
    redirect_to @request, notice: 'リクエストは受け入れられました'
  end

  def decline
    @request.declined!
    redirect_to @request, notice: 'リクエストはキャンセルされました'
  end

  def complete
    @request.completed!
    redirect_to @request, notice: 'リクエストは完了しました'
  end

    private

      def set_request
        @request = Request.find(params[:id])
      end

      def request_params
        params.require(:request).permit(:name, :photographer_id, :shooting_date, :shooting_location, :budget, :comment, :address, :phone_number)
      end
end