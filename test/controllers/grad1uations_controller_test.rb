require 'test_helper'

class GraduationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @graduation = graduations(:one)
  end

  test "should get index" do
    get graduations_url
    assert_response :success
  end

  test "should get new" do
    get new_graduation_url
    assert_response :success
  end

  test "should create graduation" do
    assert_difference('Graduation.count') do
      post graduations_url, params: { graduation: { belt_id: @graduation.belt_id, graduation_date: @graduation.graduation_date, student_id: @graduation.student_id } }
    end

    assert_redirected_to graduation_url(Graduation.last)
  end

  test "should show graduation" do
    get graduation_url(@graduation)
    assert_response :success
  end

  test "should get edit" do
    get edit_graduation_url(@graduation)
    assert_response :success
  end

  test "should update graduation" do
    patch graduation_url(@graduation), params: { graduation: { belt_id: @graduation.belt_id, graduation_date: @graduation.graduation_date, student_id: @graduation.student_id } }
    assert_redirected_to graduation_url(@graduation)
  end

  test "should destroy graduation" do
    assert_difference('Graduation.count', -1) do
      delete graduation_url(@graduation)
    end

    assert_redirected_to graduations_url
  end
end
