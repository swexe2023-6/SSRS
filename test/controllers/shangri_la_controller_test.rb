require "test_helper"

class ShangriLaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get shangri_la_index_url
    assert_response :success
  end
end
