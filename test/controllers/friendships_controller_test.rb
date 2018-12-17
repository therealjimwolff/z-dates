require 'test_helper'

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @anakin = users(:anakin)
  end

  test "should get index" do
    sign_in @anakin
    get user_friends_path(@anakin)
    assert_response :success
  end

  test "should be signed in to remove friend" do
    assert_no_difference 'Friendship.count' do
      delete friendship_path(friendships(:one))
    end
    assert_redirected_to new_user_session_path
  end

  test 'should be signed-in to view friends' do
    get user_friends_path(@anakin)
    assert_redirected_to new_user_session_path
  end

end
