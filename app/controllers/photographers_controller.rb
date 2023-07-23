# frozen_string_literal: true

class PhotographersController < ApplicationController
  before_action :authenticate_photographer!, only: %i[edit update]
  before_action :correct_photographer, only: %i[edit update]

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

  def requests
    @photographer = Photographer.find(params[:id])
    @requests = @photographer.requests.order(created_at: :desc)
  end

  def index
    @photographers = if params[:search].present?
                       Photographer.where('name LIKE ?', "%#{params[:search]}%").page(params[:page]).per(20)
                     elsif params[:tag].present?
                       Photographer.tagged_with(params[:tag]).page(params[:page]).per(20)
                     else
                       Photographer.none
                     end
    @example_tags = %w[洋装 和装 チャペル 神社 前撮り] # 検索フォームの下に表示するタグ
  end

  private

  def photographer_params
    params.require(:photographer).permit(:name, :description, :email, :your, :other, :attributes, :tag_list)
  end

  def authenticate_photographer!
    return if photographer_signed_in?

    redirect_to new_photographer_session_path, alert: 'Please sign in to access this page.'
  end

  def correct_photographer
    @photographer = Photographer.find(params[:id])
    redirect_to root_path, alert: 'アクセスが拒否されました' unless current_photographer == @photographer
  end
end
