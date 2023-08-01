class MessagesController < ApplicationController
  before_action :authenticate_user_or_photographer

  private

  def check_status
    case @request.status?
    when 'accepted'
      # なにもしない
    when 'declined'
      flash[:error] = 'このリクエストは閉じられました'
      redirect_to requests_path
    when 'completed'
      # なにもしない
    when 'offered'
      flash[:error] = 'このリクエストは承認されていません'
      redirect_to requests_path
    end
  end

  def authenticate_user_or_photographer
    unless user_signed_in? || photographer_signed_in?
      redirect_to new_user_session_path, alert: 'ログインしてください'
    end
  end
end
