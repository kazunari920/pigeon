# frozen_string_literal: true

class PortfoliosController < ApplicationController
  before_action :correct_photographer!, only: %i[new create destroy_multiple destroy_form]

  def new
    @photographer = Photographer.find(params[:photographer_id])
    @portfolio = @photographer.portfolios.build
  end

  def create
    @photographer = Photographer.find(params[:photographer_id])
    @portfolio = @photographer.portfolios.build(portfolio_params)

    if @portfolio.save
      redirect_to [@photographer, @portfolio]
    else
      render 'new'
    end
  end

  def show
    @photographer = Photographer.find(params[:photographer_id])
    @portfolio = @photographer.portfolios.find(params[:id])
  end

  def destroy_form
    @photographer = Photographer.find(params[:photographer_id])
    @portfolios = @photographer.portfolios
  end

  def destroy_multiple
    @photographer = Photographer.find(params[:photographer_id])
    @portfolios = @photographer.portfolios.where(id: params[:ids])

    @portfolios.each do |portfolio|
      portfolio.images.purge
    end

    redirect_to photographer_path(@photographer), notice: '画像の削除に成功しました'
  end

  private

  def portfolio_params
    params.require(:portfolio).permit(:title, :description, images: [])
  end
end
