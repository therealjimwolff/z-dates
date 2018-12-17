require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:anakin)
  end

  test 'should redirect show when not logged in' do
    get user_path(@user)
    assert_redirected_to new_user_session_url
  end

  test 'should redirect index when not logged in' do
    get users_path
    assert_redirected_to new_user_session_url
  end

  test 'should redirect edit when not logged in' do
    get edit_user_registration_path
    assert_not flash.empty?
    assert_redirected_to new_user_session_url
  end

  test 'should redirect update when not logged in' do
    patch user_registration_path, params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to new_user_session_url
  end
end
