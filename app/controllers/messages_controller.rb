class MessagesController < ApplicationController
  before_action :authenticate_user_or_photographer

  private

  def check_status
    if @request.pending?
      flash[:error] = 'このリクエストは承認されていません'
      redirect_to requests_path
    elsif @request.completed?
      flash[:error] = 'このリクエストは閉じられました'
      redirect_to requests_path
    end
  end

  def authenticate_user_or_photographer
    unless user_signed_in? || photographer_signed_in?
      redirect_to new_user_session_path, alert: 'ログインしてください'
    end
  end
end
