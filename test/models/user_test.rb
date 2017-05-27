# File name: user_test.rb
# Class name: UserTest
# Description: This class define all of the User model

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  #This setup setting and save two generic users to be tested
  def setup
    user_1 = {
      :first_name => "John",
      :last_name => "Doe",
      :username => "johndoe",
      :email => "johndoe@email.com",
      :password => "123456",
      :password_confirmation => "123456",
      :birthday => "11/02/1993",
      :gender => "Masculino"
    }

    user_2 = {
      :first_name => "Will",
      :last_name => "Smith",
      :username => "willsmith",
      :email => "willsmith@email.com",
      :password => "123456",
      :password_confirmation => "123456",
      :birthday => "25/09/1968",
      :gender => "Feminino"
    }

    User.destroy_all
    FollowAssociation.destroy_all

    @user = User.new(:id => 1, :first_name => user_1[:first_name],
    :last_name => user_1[:last_name], :username => user_1[:username],
    :email => user_1[:email], :password => user_1[:password],
    :password_confirmation => user_1[:password_confirmation],
    :birthday => user_1[:birthday], :gender => user_1[:gender])
    @user.save

    @user_2 = User.new(:id => 2, :first_name => user_2[:first_name],
    :last_name => user_2[:last_name], :username => user_2[:username],
    :email => user_2[:email], :password => user_2[:password],
    :password_confirmation => user_2[:password_confirmation],
    :birthday => user_2[:birthday], :gender => user_2[:gender])
    @user_2.save
  end

  def teardown
    FollowAssociation.destroy_all
    User.destroy_all
  end

  test "user should be valid" do
    assert(@user.valid?, "User isn't valid")
  end

  test "user_2 should be valid" do
    assert(@user_2.valid?, "User isn't valid")
  end

  test "should require a first name" do
    @user.first_name = nil
    assert_not(@user.valid?, "First name wasn't required")
  end

  test "should require a last name" do
    @user.last_name = nil
    assert_not(@user.valid?, "Last name wasn't required")
  end

  test "should require an username" do
    @user.username = nil
    assert_not(@user.valid?, "Username wasn't required")
  end

  test "should require an email" do
    @user.email = nil
    assert_not(@user.valid?, "E-mail wasn't required")
  end

  test "should require an birthday" do
    @user.birthday = nil
    assert_not(@user.valid?, "Birthday wasn't required")
  end

  test "should follow and unfollow a user" do
    assert_not(@user.following?(@user_2), "User is following other user")
    @user.follow(@user_2)
    assert(@user.following?(@user_2), "User isn't following other user")
    @user.unfollow(@user_2)
    assert_not(@user.following?(@user_2), "User is following other user")
  end

end
