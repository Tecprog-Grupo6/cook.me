require 'test_helper'

class PerfilControllerTest < ActionDispatch::IntegrationTest

  #get "/login", params: { username: @user.username, password: "123456" }

  def setup
    @user = User.new(first_name: users(:one).first_name,
    last_name: users(:one).last_name, username: users(:one).username,
    email: users(:one).email)
    @user_2 = User.new(first_name: users(:two).first_name,
    last_name: users(:two).last_name, username: users(:two).username,
    email: users(:two).email)
  end

  test "should show perfil" do
    get "/user/#{@user.username}/"
    assert_response :success, "No response"
  end

  test "should show perfil not found" do
    username_to_be_not_found = "asdfasdf"

    @user_not_found = User.find_by(username: username_to_be_not_found)
    assert_nil @user_not_found, "Username found"

    get "/user/#{username_to_be_not_found}/"
    assert_response :success, "No response"
    assert_select "p", "Este perfil não existe!", "Perfil not found message not found"
  end

  #test "should follow a user" do
  #  post "/user/#{@user_2.username}/followed_by/#{@user.username}"
  #  assert @user.following?(@user_2), "User is not following other user"
  #  assert @user_2.followers.find_by(username: @user.username), "User is not being followed"
  #end

  #test "should unfollow a user" do
  #  post "/user/#{@user_2.username}/followed_by/#{@user.username}"
  #  assert @user.following?(@user_2), "User is not following other user"
  #  assert @user_2.followers.find_by(username: @user.username), "User is not being followed"
  #  post "/user/#{@user_2.username}/unfollowed_by/#{@user.username}"
  #  assert @user.following?(@user_2), "User is following other user"
  #  assert @user_2.followers.find_by(username: @user.username), "User is being followed"
  #end

end
