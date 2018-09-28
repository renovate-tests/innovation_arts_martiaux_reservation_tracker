require 'test_helper'

class StudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student = students(:one)
  end

  test "should get index" do
    get students_url
    assert_response :success
  end

  test "should get new" do
    get new_student_url
    assert_response :success
  end

  test "should create student" do
    assert_difference('Student.count') do
      post students_url, params: { student: { id: @student.id, client_id: 100,  active: @student.active, date_of_birth: @student.date_of_birth, name: @student.name } }
    end

    assert_redirected_to student_url(Student.last)
  end

  test "should not create a student if it already exists" do
    assert_difference('Student.count', 0) do
      post students_url, params: { student: { id: @student.id, client_id: @student.client_id,  active: @student.active, date_of_birth: @student.date_of_birth, name: @student.name } }
    end
    assert_response :success
  end


  test "should show student" do
    get student_url(@student)
    assert_response :success
  end

  test "should get edit" do
    get edit_student_url(@student)
    assert_response :success
  end

  test "should update student" do
    patch student_url(@student), params: { student: { client_id: @student.client_id, active: @student.active, date_of_birth: @student.date_of_birth, name: @student.name } }
    assert_redirected_to student_url(@student)
  end

  test "should destroy student" do
    assert_difference('Student.count', -1) do
      delete student_url(@student)
    end

    assert_redirected_to students_url
  end
end
