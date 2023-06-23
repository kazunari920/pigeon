class PhotographersController < ApplicationController
  before_action :authenticate_photographer!, only: [:show, :edit, :update, :destroy]

  def show
    @photographer = Photographer.find_by(id: params[:id])
  end

  private

    def photographer_params
      params.require(:photographer).permit(:name, :email)
    end
end
