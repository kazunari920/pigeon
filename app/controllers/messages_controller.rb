class MessagesController < ApplicationController

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
end
