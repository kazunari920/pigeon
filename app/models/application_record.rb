# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def find_request(id)
    requests.find_by(id: id)
  end
end
