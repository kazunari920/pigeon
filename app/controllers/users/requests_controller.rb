module Users
  class RequestsController < ::RequestsController
    include Authorizer
    before_action :correct_user!

    def show
      @user = current_user
      @request = @user.requests.find(params[:id])
    end
  end
end
