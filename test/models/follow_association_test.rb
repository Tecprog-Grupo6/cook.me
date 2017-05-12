require 'test_helper'

class FollowAssociationTest < ActiveSupport::TestCase

  def setup
    user_1 = {
      :first_name => "John",
      :last_name => "Doe",
      :username => "johndoe",
      :email => "johndoe@email.com",
      :password => "123456",
      :password_confirmation => "123456"
    }

    user_2 = {
      :first_name => "Will",
      :last_name => "Smith",
      :username => "willsmith",
      :email => "willsmith@email.com",
      :password => "123456",
      :password_confirmation => "123456"
    }

    User.destroy_all
    FollowAssociation.destroy_all

    @user = User.new(:id => 1, :first_name => user_1[:first_name],
    :last_name => user_1[:last_name], :username => user_1[:username],
    :email => user_1[:email], :password => user_1[:password],
    :password_confirmation => user_1[:password_confirmation])
    @user.save

    @user_2 = User.new(:id => 2, :first_name => user_2[:first_name],
    :last_name => user_2[:last_name], :username => user_2[:username],
    :email => user_2[:email], :password => user_2[:password],
    :password_confirmation => user_2[:password_confirmation])
    @user_2.save

    @follow_association = FollowAssociation.new(:follower_id => @user.id,
                                                :followed_id => @user_2.id)
    @follow_association.save
  end

  def teardown
    FollowAssociation.destroy_all
    User.destroy_all
  end

  test "should be valid" do
    assert @follow_association.valid?
  end

  test "should require a follower_id" do
    @follow_association.follower_id = nil
    assert_not @follow_association.valid?
  end

  test "should require a followed_id" do
    @follow_association.followed_id = nil
    assert_not @follow_association.valid?
  end

end
