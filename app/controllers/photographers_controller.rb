class PhotographersController < ApplicationController
  before_action :authenticate_photographer!, only: [ :edit, :update, :destroy]
  before_action :correct_photographer, only: [:edit, :update, :destroy]

  def show
    @photographer = Photographer.find_by(id: params[:id])
  end

  def edit
    @photographer = Photographer.find(params[:id])
  end

  def update
    @photographer = Photographer.find(params[:id])
    if @photographer.update(photographer_params)
      redirect_to @photographer
    else
      render 'edit'
    end
  end

  def index
    if params[:search].present?
      @photographers = Photographer.where("name LIKE ?", "%#{params[:search]}%")
    else
      @photographers = Photographer.all
    end
  end

  private

    def photographer_params
      params.require(:photographer).permit(:name,:description,:email)
    end


    def authenticate_photographer!
      unless photographer_signed_in?
        redirect_to new_photographer_session_path, alert: 'Please sign in to access this page.'
      end
    end

    def correct_photographer
      @photographer = Photographer.find(params[:id])
      unless current_photographer == @photographer
        redirect_to root_path, alert: 'アクセスが拒否されました'
      end
    end
  end