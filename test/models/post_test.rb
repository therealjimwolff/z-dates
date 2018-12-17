require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:anakin)
    @post = @user.posts.build(content: 'Lorem ipsum')
  end

  test 'should be valid' do
    assert @post.valid?
  end

  test 'user should be present' do
    @post.user = nil
    assert_not @post.valid?
  end

  test 'content should be present' do
    @post.content = '   '
    assert_not @post.valid?
  end

  test 'content should be at most 400 characters' do
    @post.content = 'a' * 1001
    assert_not @post.valid?
  end

  test 'most recent first ordering' do
    assert_equal posts(:most_recent), Post.first
  end
end
