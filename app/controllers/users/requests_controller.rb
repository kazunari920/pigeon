module Users
  class RequestsController < ::RequestsController
    before_action :correct_user!

    def show
      @user = User.find(params[:user_id])
      @request = @user.find_request(params[:id])
      redirect_to requests_path, alert: 'リクエストが見つかりませんでした' unless @request
    end
  end
end
