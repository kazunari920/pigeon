module Users
  class RequestsController < ApplicationController
    def show
      @request = Request.find(params[:id])
      @user = User.find(params[:user_id])
    end
  end
end