# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:tanaka)
    @jpuser = users(:田中)
  end

  test '登録ページにアクセスできる' do
    get new_user_registration_path
    assert_response :success
  end

  test 'ログインしてユーザーのマイページにアクセスできる' do
    sign_in(@user)
    get user_path(@user)
    assert_response :success
  end
end
