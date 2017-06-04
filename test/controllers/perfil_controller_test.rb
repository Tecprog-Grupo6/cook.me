require 'test_helper'

class PerfilControllerTest < ActionDispatch::IntegrationTest

  #get "/login", params: { username: @user.username, password: "123456" }

  def setup
    user_1 = {
      :first_name => "John",
      :last_name => "Doe",
      :username => "johndoe",
      :email => "johndoe@email.com",
      :password => "123456",
      :password_confirmation => "123456",
      :birthday => "01/01/1990",
      :gender => "Masculino"
    }

    user_2 = {
      :first_name => "Will",
      :last_name => "Smith",
      :username => "willsmith",
      :email => "willsmith@email.com",
      :password => "123456",
      :password_confirmation => "123456",
      :birthday => "01/01/1990",
      :gender => "Masculino"
    }

    User.destroy_all
    FollowAssociation.destroy_all

    @user = User.new(:id => 1, :first_name => user_1[:first_name],
    :last_name => user_1[:last_name], :username => user_1[:username],
    :email => user_1[:email], :password => user_1[:password],
    :password_confirmation => user_1[:password_confirmation],
    :birthday => user_1[:birthday], :gender => user_1[:birthday])
    @user.save

    @user_2 = User.new(:id => 2, :first_name => user_2[:first_name],
    :last_name => user_2[:last_name], :username => user_2[:username],
    :email => user_2[:email], :password => user_2[:password],
    :password_confirmation => user_2[:password_confirmation],
    :birthday => user_2[:birthday], :gender => user_2[:birthday])
    @user_2.save

    #@follower_association = FollowAssociation.all
    #@follower_association.destroy_all
  end

  def teardown
    User.destroy_all
    FollowAssociation.destroy_all
  end

  test "should show perfil" do
    get "/user/#{@user.username}/"
    assert_response(:success, "No response")
  end

  test "should show perfil not found" do
    username_to_be_not_found = "asdfasdf"

    @user_not_found = User.find_by(username: username_to_be_not_found)
    assert_nil(@user_not_found, "Username found")

    get "/user/#{username_to_be_not_found}/"
    assert_response(:success, "No response")
    assert_select("p", "Este perfil não existe!", "Perfil not found message not found")
  end

  test "should follow a user" do
    post "/login", :params => { :email => 'johndoe@email.com', :password => '123456' }
    post "/user/#{@user_2.username}/followed_by/#{@user.username}"

    assert_equal(FollowAssociation.first.follower_id, @user.id, "@user isn't follower")
    assert_equal(FollowAssociation.first.followed_id, @user_2.id, "@user_2 isn't followed")
    assert_equal(@user.following.find_by(username: @user_2.username), @user_2, "User is not following other user")
    assert(@user.following?(@user_2), "User is not following other user (2)")
    assert_equal(@user_2.followers.find_by(username: @user.username), @user, "User is not being followed")
  end

  test "should unfollow a user" do
    post "/login", :params => { :email => 'johndoe@email.com', :password => '123456' }
    post "/user/#{@user_2.username}/followed_by/#{@user.username}"
    assert(@user.following?(@user_2), "User is not following other user")
    assert_equal(@user_2.followers.find_by(username: @user.username), @user, "User is not being followed")

    post "/user/#{@user_2.username}/unfollowed_by/#{@user.username}"
    assert_not(@user.following?(@user_2), "User is following other user")
    assert_not_equal(@user_2.followers.find_by(username: @user.username), @user, "User is being followed")
  end

end
