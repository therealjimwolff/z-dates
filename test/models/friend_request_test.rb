require 'test_helper'

class FriendRequestTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers

  def setup
    @anakin = users(:anakin)
    @request = @anakin.friend_requests.build(friend: users(:leia))
  end

  test 'should be valid' do
    assert @request.valid?
  end

  test 'user should be present' do
    @request.user = nil
    assert_not @request.valid?
  end

  test 'friend should be present' do
    @request.friend = nil
    assert_not @request.valid?
  end

  test 'cannot send a request to oneself' do
    @request.friend = users(:anakin)
    assert_not @request.valid?
  end

  test 'cannot send request to a friend' do
    @request.friend = users(:luke)
    assert_not @request.valid?
  end

  test 'cannot send a second request' do
    second_request = @request.dup
    @request.save
    assert_not second_request.valid?
  end
end
