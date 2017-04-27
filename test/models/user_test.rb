require 'test_helper'

class UserTest < ActiveSupport::TestCase

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
