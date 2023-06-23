require "test_helper"

class PhotographersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get photographers_show_url
    assert_response :success
  end
end
