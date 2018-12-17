require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @post = posts(:the_force)
    @user = users(:anakin)
    @like = likes(:one)
  end

  test 'creation when not signed-in' do
    assert_no_difference 'Like.count' do
      post likes_path, params: { post_id: @post.id }
    end
    assert_redirected_to new_user_session_path
  end

  test 'destruction when not signed-in' do
    assert_no_difference 'Like.count' do
      delete like_path(@like)
    end
    assert_redirected_to new_user_session_path
  end
end
