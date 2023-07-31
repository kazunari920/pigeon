module Findable
  extend ActiveSupport::Concern

  def find_request(id)
    requests.find_by(id: id)
  end
end
