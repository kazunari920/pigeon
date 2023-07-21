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
    @request = Request.find(params[:id])
    if @request.can_be_accepted_by?(current_photographer)
      @request.accept
      redirect_to @request, notice: '依頼を承認しました。'
    else
      redirect_to @request, alert: '依頼の承認に失敗しました。'
    end
  end

  def decline
    @request = Request.find(params[:id])
    if @request.can_be_declined_by?(current_photographer)
      @request.decline
      redirect_to @request, notice: '依頼を拒否しました。'
    else
      redirect_to @request, alert: '依頼の拒否に失敗しました。'
    end
  end

  def complete
    @request = Request.find(params[:id])
    if @request.can_be_completed_by?(current_photographer)
      @request.complete
      redirect_to @request, notice: 'リクエストは完了しました'
    else
      redirect_to @request, alert: 'リクエストの完了に失敗しました'
    end
  end


  private

  def set_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit(:name, :photographer_id, :shooting_date, :shooting_location, :budget, :comment, :address, :phone_number)
  end
end