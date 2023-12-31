# frozen_string_literal: true

require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get home' do
    get root_path
    assert_response :success
  end

  test 'should get help' do
    get help_path
    assert_response :success
  end

  # test "should get about" do
  # get static_pages_about_url
  # assert_response :success
  # end
end
