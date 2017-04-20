require 'test_helper'

class PerfilControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get perfil_show_url
    assert_response :success
  end

end
