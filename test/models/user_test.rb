require 'test_helper'

class UserTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:anakin)
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = ''
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 'a' * 244 + '@example.com'
    assert_not @user.valid?
  end

  test 'valid email formats should be accepted' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn] # From Hartl tut
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} should be valid."
    end
  end

  test 'invalid email formats should be rejected' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com] # Fomr Hartl tut
    invalid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address.inspect} should be invalid."
    end
  end

  test 'emails should be unique' do
    dup_user = @user.dup
    dup_user.email.upcase
    @user.save
    assert_not dup_user.valid?
  end

  test 'emails should be saved in lowercase' do
    @user.email = 'UseR@eXamPle.COM'
    lc_email = 'user@example.com'
    @user.save
    assert_equal @user.reload.email, lc_email
  end

  test 'passwords should not be blank' do
    @user.password = @user.password_confirmation = ' ' * 7
    assert_not @user.valid?
  end

  test 'passwords must be at least 6 character long' do
    @user.password = @user.password_confirmation = 'a'
    assert_not @user.valid?
  end

  test "user's posts should be destroyed on user destruction" do
    @user.posts.create!(content: 'Lorem ipsum')
    assert_difference 'Post.count', -3 do
      @user.destroy
    end
  end

  test 'user should not be able to like his own posts' do
    sign_in @user
    assert_no_difference 'Like.count' do
      @user.likes.create(post: posts(:podracer))
    end
  end

  test 'user can only like a post once' do
    sign_in @user
    assert_no_difference 'Like.count' do
      @user.likes.create(post: posts(:the_force))
    end
  end

  test 'associated likes should be destroyed' do
    assert_difference 'Like.count', -2 do
      @user.destroy
    end
  end

  test 'associated comments should be destroyed' do
    assert_difference 'Comment.count', -2 do
      @user.destroy
    end
  end

  test 'feed should contain only own and friend posts' do
    anakin = users(:anakin)
    luke = users(:luke)
    han = users(:han)

    # Posts from friend
    luke.posts.each do |friend_post|
      assert anakin.feed.include?(friend_post)
    end
    # Posts from self
    anakin.posts.each do |self_post|
      assert anakin.feed.include?(self_post)
    end
    # Posts from non-friend
    han.posts.each do |non_friend_post|
      assert_not anakin.feed.include?(non_friend_post)
    end
  end
end
