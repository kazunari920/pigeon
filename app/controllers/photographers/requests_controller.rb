module Photographers
  class RequestsController < ::RequestsController
    before_action :correct_photographer!

    def show
      @photographer = current_photographer
      @request = @photographer.requests.find(params[:id])
    end
  end
end
