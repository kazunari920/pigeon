module Authorizer
  extend ActiveSupport::Concern

  private

  def correct_user!
    unless current_user
      redirect_to root_path, alert: 'ログインしてください'
    end
  end

  def correct_photographer!
    unless current_photographer
      redirect_to root_path, alert: 'ログインしてください'
    end
  end
end