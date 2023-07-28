module Photographers
  class RequestsController < ::RequestsController
    before_action :correct_photographer!

    def show
      @photographer = Photographer.find(params[:photographer_id])
      @request = @photographer.requests.find_by(id: params[:id])
      unless @request

      redirect_to photographer_path(current_photographer), alert: 'リクエストが見つかりませんでした'
      end
    end
  end
end
