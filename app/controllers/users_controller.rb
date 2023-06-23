class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy]

  def show
    @user = User.find_by(id: params[:id])
  end


  private

    def user_params
      params.require(:user).permit(:name, :email)
    end
end
