require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @course = courses(:one)
    sign_in admins(:one)
  end

  test "should get index" do
    get courses_url
    assert_response :success
  end

  test "should get new" do
    get new_course_url
    assert_response :success
  end

  test "should create course" do
    assert_difference('Course.count') do
      post courses_url, params: { course: { course_id: @course.id, course_type_id: @course.course_type_id, day_of_week: @course.day_of_week, number_of_students_allowed: @course.number_of_students_allowed, timeslot_id: @course.timeslot_id, age_group_id: @course.age_group_id} }
    end

    assert_redirected_to course_url(Course.last)
  end

  test "should show course" do
    get course_url(@course)
    assert_response :success
  end

  test "should get edit" do
    get edit_course_url(@course)
    assert_response :success
  end

  test "should update course" do
    patch course_url(@course), params: { course: {course_id: @course.id,  course_type_id: @course.course_type_id, day_of_week: @course.day_of_week, number_of_students_allowed: @course.number_of_students_allowed, timeslot_id: @course.timeslot_id } }
    assert_redirected_to course_url(@course)
  end

  test "should destroy course" do
    assert_difference('Course.count', -1) do
      delete course_url(@course)
    end

    assert_redirected_to courses_url
  end
end
