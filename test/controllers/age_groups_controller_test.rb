require 'test_helper'

class AgeGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @age_group = age_groups(:test_case)
  end

  test "should get index" do
    get age_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_age_group_url
    assert_response :success
  end

  test "should create age_group" do
    assert_difference('AgeGroup.count') do
      post age_groups_url, params: { age_group: { id: @age_group.id , name: @age_group, min_age: @age_group.min_age , max_age: @age_group.max_age } }
    end

    assert_redirected_to age_group_url(AgeGroup.last)
  end

  test "should show age_group" do
    get age_group_url(@age_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_age_group_url(@age_group)
    assert_response :success
  end

  test "should update age_group" do
    patch age_group_url(@age_group), params: { age_group: { id: @age_group.id ,name: @age_group.name, min_age: @age_group.min_age , max_age: @age_group.max_age } }
    assert_redirected_to age_group_url(@age_group)
  end

  test "should destroy age_group" do
    assert_difference('AgeGroup.count', -1) do
      delete age_group_url(@age_group)
    end

    assert_redirected_to age_groups_url
  end
end
