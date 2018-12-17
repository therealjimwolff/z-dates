require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:anakin)
    sign_in @user
  end

  test 'an unsuccessful edit' do
    get edit_user_registration_path
    assert_template 'devise/registrations/edit'
    patch user_registration_path, params: { user: { name:  "",
                                                    email: "foo@invalid",
                                                    password:              "foo",
                                                    password_confirmation: "bar" } }

    assert_template 'devise/registrations/edit'
  end

  test 'a successful edit' do
    get edit_user_registration_path
    assert_template 'devise/registrations/edit'
    name  = 'Foo Bar'
    email = 'foo@bar.com'
    patch user_registration_path, params: { user: { name:  name,
                                                    email: email,
                                                    password: '',
                                                    password_confirmation: '',
                                                    current_password: 'password' } }
    follow_redirect!
    assert_not flash.empty?
    assert_template 'static_pages/home'
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
end
