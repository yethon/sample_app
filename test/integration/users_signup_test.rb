require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert flash[:danger]
    assert_not flash[:success]

    assert_select '#name', "name can't be blank"
    assert_select '.field_with_errors input#user_name'

    assert_select '#email', "email is invalid"
    assert_select '.field_with_errors input#user_email'

    assert_select '#password', "password is too short (minimum is 6 characters)"
    assert_select '.field_with_errors input#user_password'
  end

  test "valid signup" do
    get signup_path
    assert_difference 'User.count', 1 do
    # assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "Example User",
        email: "user@example.com",
        password:              "password",
        password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash[:danger]
    assert flash[:success]

  end
end
