require 'test_helper'

class BeltsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @belt = belts(:white)
  end

  test "should get index" do
    get belts_url
    assert_response :success
  end

  test "should get new" do
    get new_belt_url
    assert_response :success
  end

  test "should create belt" do
    assert_difference('Belt.count') do
      post belts_url, params: { belt: { color: @belt.color } }
    end

    assert_redirected_to belt_url(Belt.last)
  end

  test "should show belt" do
    get belt_url(@belt)
    assert_response :success
  end

  test "should get edit" do
    get edit_belt_url(@belt)
    assert_response :success
  end

  test "should update belt" do
    patch belt_url(@belt), params: { belt: { color: @belt.color } }
    assert_redirected_to belt_url(@belt)
  end

  test "should destroy belt" do
    assert_difference('Belt.count', -1) do
      delete belt_url(@belt)
    end

    assert_redirected_to belts_url
  end
end
