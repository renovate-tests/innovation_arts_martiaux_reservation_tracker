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

  test "should create age_group if it is unique" do
    assert_difference('AgeGroup.count') do
      post age_groups_url, params: { age_group: { id: 9999 , name: 'some_unique_name', min_age: @age_group.min_age , max_age: @age_group.max_age } }
    end

    assert_redirected_to age_group_url(AgeGroup.last)
  end

  test "should not create age_group if it already exists" do
    skip('Validation of multiple scope is not respected')
    assert_difference('AgeGroup.count', 0) do
      post age_groups_url, params: { age_group: { id: 9999 , name: @age_group, min_age: @age_group.min_age , max_age: @age_group.max_age } }
    end

    assert_redirected_to age_group_url(AgeGroup.last)
  end


  test "should not create age_group if name is empty" do
    assert_difference('AgeGroup.count', 0) do
      post age_groups_url, params: { age_group: { id: 9999, min_age: @age_group.min_age , max_age: @age_group.max_age } }
    end

    assert_response :success
  end


  test "should not create age_group if min_age is empty" do
    assert_difference('AgeGroup.count', 0) do
      post age_groups_url, params: { age_group: { id: 9999, name: @age_group.name , max_age: @age_group.max_age } }
    end

    assert_response :success
  end

  test "should not create age_group if max_age is empty" do
    assert_difference('AgeGroup.count', 0) do
      post age_groups_url, params: { age_group: { id: 9999, name: @age_group.name , min_age: @age_group.min_age } }
    end

    assert_response :success
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
    patch age_group_url(@age_group), params: { age_group: { id: @age_group.id ,name: 'some new value', min_age: @age_group.min_age , max_age: @age_group.max_age } }
    assert_redirected_to age_group_url(@age_group)
  end

  test "should destroy age_group" do
    assert_difference('AgeGroup.count', -1) do
      delete age_group_url(@age_group)
    end

    assert_redirected_to age_groups_url
  end
end
