module Photographers
  class RequestsController < ::RequestsController
    before_action :correct_photographer!

    def show
      @photographer = Photographer.find(params[:photographer_id])
      @request = @photographer.find_request(params[:id])
      redirect_to requests_path, alert: 'リクエストが見つかりませんでした' unless @request
    end
  end
end
