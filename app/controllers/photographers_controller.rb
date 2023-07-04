# frozen_string_literal: true

class PhotographersController < ApplicationController
  before_action :authenticate_photographer!, only: %i[edit update destroy]
  before_action :correct_photographer, only: %i[edit update destroy]

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
    @photographers = if params[:search].present?
                       Photographer.where('name LIKE ?', "%#{params[:search]}%").page(params[:page]).per(20)
                     else
                       Photographer.none
                     end
  end

  private

  def photographer_params
    params.require(:photographer).permit(:name, :description, :email)
  end

  def authenticate_photographer!
    unless photographer_signed_in?
      redirect_to new_photographer_session_path, alert: 'Please sign in to access this page.'
    end
  end

  def correct_photographer
    @photographer = Photographer.find(params[:id])
    redirect_to root_path, alert: 'アクセスが拒否されました' unless current_photographer == @photographer
  end
end
