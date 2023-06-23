class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy]

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?

    else
      # ユーザーが存在する場合の処理
      # 例: ユーザーの詳細情報を表示する
    end
  end


  private

    def user_params
      #ストロングパラメータで、名前とメールを受け取ることができるように設定しておく。
      params.require(:user).permit(:name, :email)
    end
end
