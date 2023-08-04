class RequestsController < ApplicationController
  before_action :set_request, only: %i[accept decline complete]

  def new
    @request = Request.new(photographer_id: params[:photographer_id])
  end

  def create
    @request = current_user.requests.build(request_params)
    if @request.save
      redirect_to user_request_path(current_user, @request), notice: 'リクエストの作成に成功しました'
    else
      render :new
    end
  end

  def index
    if current_user
      @requests = current_user.requests
    elsif current_photographer
      @requests = current_photographer.requests
    else
      redirect_to login_path, alert: 'ログインが必要です'
      return
    end
    @requests = @requests.where(status: params[:status]) if params[:status].present?
  end

  def user_requests
    @requests = current_user.requests
  end

  def accept
    @request = Request.find(params[:id])
    if @request.accept(current_photographer)
      @request.initial_message(current_photographer)
      redirect_to photographer_request_path(current_photographer, @request), notice: '依頼を承認しました。'
    else
      redirect_to photographer_request_path(current_photographer, @request), alert: '依頼の承認に失敗しました。'
    end
  end

  def decline
    @request = Request.find(params[:id])
    if @request.decline(current_photographer)
      redirect_to photographer_request_path(current_photographer, @request), notice: '依頼を拒否しました。'
    else
      redirect_to photographer_request_path(current_photographer, @request), alert: '依頼の拒否に失敗しました。'
    end
  end

  def complete
    @request = Request.find(params[:id])
    if @request.complete(current_photographer)
      redirect_to photographer_request_path(current_photographer, @request), notice: 'リクエストは完了しました'
    else
      redirect_to photographer_request_path(current_photographer, @request), alert: 'リクエストの完了に失敗しました'
    end
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit(:name, :photographer_id, :shooting_date, :shooting_location,
                                    :budget, :comment, :address, :phone_number)
  end
end
