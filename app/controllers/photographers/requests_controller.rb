module Photographers
  class RequestsController < ::RequestsController
    before_action :correct_photographer

    def show
      @request = Request.find(params[:id])
    end
  end
end