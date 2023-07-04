# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # 新規登録時(sign_up時)にnameというキーのパラメーターを追加で許可する
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def after_sign_out_path_for(_resource)
    root_path \
  end
end
