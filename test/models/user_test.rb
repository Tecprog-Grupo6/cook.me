require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(first_name: users(:one).first_name,
    last_name: users(:one).last_name, username: users(:one).username,
    email: users(:one).email)
  end

  test "should require a first name" do
    @user.first_name = nil
    assert_not @user.valid?
  end

  test "should require a last name" do
    @user.last_name = nil
    assert_not @user.valid?
  end

  test "should require an username" do
    @user.username = nil
    assert_not @user.valid?
  end

  test "should require an email" do
    @user.email = nil
    assert_not @user.valid?
  end

  test "should follow and unfollow a user" do
    user_one = users(:one)
    user_two  = users(:two)
    assert_not user_one.following?(user_two)
    user_one.follow(user_two)
    assert user_one.following?(user_two)
    user_one.unfollow(user_two)
    assert_not user_one.following?(user_two)
  end

end
