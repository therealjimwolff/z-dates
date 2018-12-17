require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @comment = comments(:comment1)
  end

  test 'should redirect create when not signed in' do
    assert_no_difference 'Comment.count' do
      post comments_path, params: { comment: { content: 'Lorem ipsum',
                                               post_id: posts(:the_force) } }
    end
    assert_redirected_to new_user_session_path
  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'Comment.count' do
      delete comment_path(@comment)
    end
    assert_redirected_to new_user_session_path
  end

  test 'should redirect destroy for wrong comment' do
    sign_in (users(:anakin))
    comment = comments(:comment2)
    assert_no_difference 'Comment.count' do
      delete comment_path(comment)
    end
    assert_redirected_to root_url
  end
end
