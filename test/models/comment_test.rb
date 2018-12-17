require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:anakin)
    @post = users(:luke).posts.build(content: 'Lorem ipsum')
    @comment = @post.comments.build(user: @user, content: 'Lorem ipsum')
  end

  test "validity" do
    assert @comment.valid?
  end

  test "when user is not present" do
    @comment.user = nil
    assert_not @comment.valid?
  end

  test "when post is not present" do
    @comment.post = nil
    assert_not @comment.valid?
  end

  test "when content is not present" do
    @comment.content = '  '
    assert_not @comment.valid?
  end

  test "when content is too long" do
    @comment.content = 'a' * 401
    assert_not @comment.valid?
  end
end
