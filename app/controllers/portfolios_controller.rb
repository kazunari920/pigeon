class PortfoliosController < ApplicationController
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

  private

  def portfolio_params
    params.require(:portfolio).permit(:title, :description, images: [])
  end
end
