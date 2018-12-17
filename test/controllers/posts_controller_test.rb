require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @post = posts(:the_force)
  end

  test 'creation when not signed-in' do
    assert_no_difference 'Post.count' do
      post posts_path, params: { post: { content: 'Lorem ipsum' } }
    end
    assert_redirected_to new_user_session_path
  end

  test 'destruction when not sign-in' do
    assert_no_difference 'Post.count' do
      delete post_path(@post)
    end
    assert_redirected_to new_user_session_path
  end
end
