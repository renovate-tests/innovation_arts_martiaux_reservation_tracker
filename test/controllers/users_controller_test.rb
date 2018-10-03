require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user if it has unique data" do
    assert_difference('user.count') do
      post users_url, params: {user: {id: 9999, email: 'some_unique_email@invalidemail.com', name: 'some unique name', telephone: '555-555-9999'}}
    end

    assert_redirected_to user_url(user.last)
  end

  test "should not create user if name exists" do
    assert_difference 'user.count', 0 do
      post users_url, params: {user: {id: 9998, email: 'some_unique_email2@invalidemail.com', name: @user.name, telephone: '555-555-9998'}}
    end
    assert_response :success
  end


  test "should not create user if name is empty" do
    assert_difference 'user.count', 0 do
      post users_url, params: {user: {id: 9998, email: 'some_unique_email2@invalidemail.com', telephone: '555-555-9998'}}
    end
    assert_response :success
  end

  test "should not create user if telephone exists" do
    assert_difference 'user.count', 0 do
      post users_url, params: {user: {id: 9998, email: 'some_unique_email2@invalidemail.com', name: 'some_unique_name2', telephone: @user.telephone}}
    end
    assert_response :success
  end

  test "should not create user if telephone is empty" do
    assert_difference 'user.count', 0 do
      post users_url, params: {user: {id: 9998, email: 'some_unique_email2@invalidemail.com', name: 'some_unique_name2'}}
    end
    assert_response :success
  end

  test "should not create user if email exists" do
    assert_difference 'user.count', 0 do
      post users_url, params: {user: {id: 9998, email: @user.email, name: 'some_unique_name2', telephone: '555-555-9997'}}
    end
    assert_response :success
  end

  test "should not create user if email is empty" do
    assert_difference 'user.count', 0 do
      post users_url, params: {user: {id: 9998, name: 'some_unique_name2', telephone: '555-555-9997'}}
    end
    assert_response :success
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: {user: {id: @user.id, email: @user.email, name: @user.name, telephone: @user.telephone}}
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('user.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
