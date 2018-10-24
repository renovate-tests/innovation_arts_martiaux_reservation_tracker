require 'test_helper'

class StudentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @student = students(:one)
    sign_in users(:three)
  end

  test "should get index as a user" do
    get students_url
    assert_response :success
  end

  test "should get new as a user" do
    get new_student_url
    assert_response :success
  end

  test "should create student as a user" do
    assert_difference('Student.count') do
      post students_url, params: {student: {id: @student.id, user_id: 100, active: @student.active, date_of_birth: @student.date_of_birth, name: @student.name}}
    end

    assert_redirected_to student_url(Student.last)
  end

  test "should not create a student if it already exists as a user" do
    assert_difference('Student.count', 0) do
      post students_url, params: {student: {id: @student.id, user_id: @student.user_id, active: @student.active, date_of_birth: @student.date_of_birth, name: @student.name}}
    end
    assert_response :success
  end


  test "should not create a student if it has no name as a user" do
    assert_difference('Student.count', 0) do
      post students_url, params: {student: {id: @student.id, user_id: @student.user_id, active: @student.active, date_of_birth: @student.date_of_birth}}
    end
    assert_response :success
  end

  test "should show student as a user" do
    get student_url(@student)
    assert_response :success
  end

  test "should get edit as a user" do
    get edit_student_url(@student)
    assert_response :success
  end

  test "should update student as a user" do
    patch student_url(@student), params: {student: {user_id: @student.user_id, active: @student.active, date_of_birth: @student.date_of_birth, name: @student.name}}
    assert_redirected_to student_url(@student)
  end

  test "should destroy student as a user" do
    assert_difference('Student.count', -1) do
      delete student_url(@student)
    end

    assert_redirected_to students_url
  end


  setup do
    @student = students(:one)
    sign_in admins(:one)
  end

  test "should get index as an admin" do
    get students_url
    assert_response :success
  end

  test "should get new as an admin" do
    get new_student_url
    assert_response :success
  end

  test "should create student as an admin" do
    assert_difference('Student.count') do
      post students_url, params: {student: {id: @student.id, user_id: 100, active: @student.active, date_of_birth: @student.date_of_birth, name: @student.name}}
    end

    assert_redirected_to student_url(Student.last)
  end

  test "should not create a student if it already exists as an admin" do
    assert_difference('Student.count', 0) do
      post students_url, params: {student: {id: @student.id, user_id: @student.user_id, active: @student.active, date_of_birth: @student.date_of_birth, name: @student.name}}
    end
    assert_response :success
  end


  test "should not create a student if it has no name as an admin" do
    assert_difference('Student.count', 0) do
      post students_url, params: {student: {id: @student.id, user_id: @student.user_id, active: @student.active, date_of_birth: @student.date_of_birth}}
    end
    assert_response :success
  end

  test "should show student as an admin" do
    get student_url(@student)
    assert_response :success
  end

  test "should get edit as an admin" do
    get edit_student_url(@student)
    assert_response :success
  end

  test "should update student as an admin" do
    patch student_url(@student), params: {student: {user_id: @student.user_id, active: @student.active, date_of_birth: @student.date_of_birth, name: @student.name}}
    assert_redirected_to student_url(@student)
  end

  test "should destroy student as an admin" do
    assert_difference('Student.count', -1) do
      delete student_url(@student)
    end

    assert_redirected_to students_url
  end


end
