require 'test_helper'

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @reservation = reservations(:one)
    sign_in users(:one)

  end

  test "should get index" do
    get reservations_url
    assert_response :success
  end

  test "should get new" do
    get new_reservation_url
    assert_response :success
  end

  test "should create reservation" do
    assert_difference('Reservation.count') do
      post reservations_url, params: {reservation: {id: @reservation.id, active: @reservation.active, course_id: 1, student_id: @reservation.student_id}}
    end

    assert_redirected_to reservation_url(Reservation.last)
  end

  test "should not create reservation if it already exists" do
    assert_difference('Reservation.count', 0) do
      post reservations_url, params: {reservation: {id: Reservation.last.id, active: Reservation.last.active, course_id: Reservation.last.course_id, student_id: Reservation.last.id}}
    end
    assert_response :success
  end


  test "should show reservation" do
    get reservation_url(@reservation)
    assert_response :success
  end

  test "should get edit" do
    get edit_reservation_url(@reservation)
    assert_response :success
  end

  test "should update reservation" do
    patch reservation_url(@reservation), params: {reservation: {active: @reservation.active, course_id: @reservation.course_id, student_id: @reservation.student_id}}
    assert_redirected_to reservation_url(@reservation)
  end

  test "should destroy reservation" do
    assert_difference('Reservation.count', -1) do
      delete reservation_url(@reservation)
    end

    assert_redirected_to reservations_url
  end
end
