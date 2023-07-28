module Users
  class RequestsController < ::RequestsController
    def show
      @request = Request.find(params[:id])
      @user = User.find(params[:user_id])
    end
  end
end
