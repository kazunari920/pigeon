class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :update, :accept, :decline, :complete]
  before_action :authenticate_photographer!, only: [:index]
  before_action :check_ownership, only: [:show, :update, :accept, :decline, :complete]

  def index
    @requests = current_photographer.requests
  end

  def new
    @request = Request.new(photographer_id: params[:photographer_id])
  end

  def create
    @request = current_user.requests.build(request_params)
    @request.photographer_id = params[:photographer_id]
    if @request.save
      redirect_to @request, notice: 'リクエストの作成に成功しました'
    else
      render :new
    end
  end

  def show
  end

  def update
    if @request.update(request_params)
      redirect_to @request, notice: 'リクエストの更新に成功しました'
    else
      render :edit
    end
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
        params.require(:request).permit(:photographer_id, :shooting_date, :shooting_location, :budget, :comment, :address, :phone_number)
      end

      def check_ownership
        redirect_to root_path unless @request.photographer == current_photographer
      end
end