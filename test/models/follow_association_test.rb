require 'test_helper'

class FollowAssociationTest < ActiveSupport::TestCase
  
  def setup
    @follow_association = FollowAssociation.new(follower_id: users(:one).id,
                                     followed_id: users(:two).id)
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
