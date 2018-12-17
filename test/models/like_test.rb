require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @user = users(:anakin)
    @post = users(:luke).posts.build(content: 'Lorem ipsum')
    @like = @post.likes.build(user: @user)
  end

  test 'should be valid' do
    assert @like.valid?
  end

  test 'user should be present' do
    @like.user = nil
    assert_not @post.valid?
  end

  test 'post should be present' do
    @like.post = nil
    assert_not @like.valid?
  end

  test 'user liking own post' do
    like = posts(:podracer).likes.build(user: @user)
    assert_not like.valid?
  end
end
