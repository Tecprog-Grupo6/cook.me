require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest

  test "should show home" do
    get "/"
    assert_response :success
  end

end
