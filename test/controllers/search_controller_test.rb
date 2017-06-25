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
        :password_confirmation => "123456",
        :birthday => "01/01/1990",
        :gender => "Masculino"
      }

    @user = User.new(:id => 1, :first_name => @user_1[:first_name],
    :last_name => @user_1[:last_name], :username => @user_1[:username],
    :email => @user_1[:email], :password => @user_1[:password],
    :password_confirmation => @user_1[:password_confirmation],
    :birthday => @user_1[:birthday], :gender => @user_1[:birthday])
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
    assert_response(:redirect, "No redirect")
  end

  test "should return results" do
    get "/buscar/#{@user_1[:first_name]}"
    assert_select("h4", "Nome: #{@user_1[:first_name]} #{@user_1[:last_name]}", "User wasn't found")
  end

  test "shouldn't return results" do
    get "/buscar/#{@user_1[:first_name]}"
    assert_select("body", { count: 0, text: "Nome: #{@user_1[:first_name]} #{@user_1[:last_name]}" }, "User was found")
  end

end
