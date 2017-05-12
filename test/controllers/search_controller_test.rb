require 'test_helper'

class SearchControllerTest < ActionDispatch::IntegrationTest

  def setup
    User.destroy_all

    @user_1 =  {
        :first_name => "John",
        :last_name => "Doe",
        :username => "johndoe",
        :email => "johndoe@email.com",
        :password => "123456",
        :password_confirmation => "123456"
      }

    @user = User.new(:id => 1, :first_name => @user_1[:first_name],
    :last_name => @user_1[:last_name], :username => @user_1[:username],
    :email => @user_1[:email], :password => @user_1[:password],
    :password_confirmation => @user_1[:password_confirmation])
    @user.save
  end

  def teardown
    User.destroy_all
  end

  test "get should responds" do
    get "/buscar"
    assert_response(:success, "No response")
  end

  test "post should responds" do
    post "/buscar", :params => {:query => "John"}
    assert_response(:success, "No response")
  end

  test "should return results" do
    post "/buscar", :params => {:query => @user_1[:first_name]}
    assert_select("a", "Nome: #{@user_1[:first_name]} #{@user_1[:last_name]}", "User wasn't found")
  end

  test "shouldn't return results" do
    post "/buscar", :params => {:query => ""}
    assert_select("a", { count: 0, text: "Nome: #{@user_1[:first_name]} #{@user_1[:last_name]}" }, "User was found")
  end

end
