require 'test_helper'

class UsersSigninTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:anakin)
  end

  test 'sign in with invalid credentials' do
    get new_user_session_path
    assert_template 'devise/sessions/new'
    post user_session_path, params: { user: { email: '', password: '' } }
    assert_template 'devise/sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'sign in with valid credentials' do
    get new_user_session_path
    assert_template 'devise/sessions/new'
    post user_session_path, params: { user: { email: @user.email,
                                              password: 'password' } }
    assert_redirected_to root_path
    follow_redirect!
    assert_not flash.empty?
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', new_user_session_path, count: 0
    assert_select 'a[href=?]', destroy_user_session_path
    assert_select 'a[href=?]', user_path(@user)
  end

  test 'sign out signed-in user' do
    sign_in @user
    get user_path(@user)
    assert_select 'a[href=?]', new_user_session_path, count: 0
    assert_select 'a[href=?]', destroy_user_session_path
    delete destroy_user_session_path
    assert_redirected_to root_path
    follow_redirect!
    assert_not flash.empty?
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', new_user_session_path
    assert_select 'a[href=?]', destroy_user_session_path, count: 0
  end
end
