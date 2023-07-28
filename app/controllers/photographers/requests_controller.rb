module Photographers
    class RequestsController < ::RequestsController
        def show
          @request = Request.find(params[:id])
        end
    end
end