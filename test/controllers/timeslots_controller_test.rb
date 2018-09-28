require 'test_helper'

class TimeslotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @timeslot = timeslots(:one)
  end

  test "should get index" do
    get timeslots_url
    assert_response :success
  end

  test "should get new" do
    get new_timeslot_url
    assert_response :success
  end

  test "should create timeslot" do
    assert_difference('Timeslot.count') do
      post timeslots_url, params: { timeslot: { id: @timeslot.id, end_time: @timeslot.end_time, start_time: '23:59'} }
    end

    assert_redirected_to timeslot_url(Timeslot.last)
  end

  test "should not create a timeslot if it already exists" do
    assert_difference('Timeslot.count', 0) do
      post timeslots_url, params: { timeslot: { id: @timeslot.id, end_time: @timeslot.end_time, start_time: @timeslot.start_time } }
    end

    assert_response :success
  end


  test "should show timeslot" do
    get timeslot_url(@timeslot)
    assert_response :success
  end

  test "should get edit" do
    get edit_timeslot_url(@timeslot)
    assert_response :success
  end

  test "should update timeslot" do
    patch timeslot_url(@timeslot), params: { timeslot: { id: @timeslot.id, end_time: @timeslot.end_time, start_time: @timeslot.start_time } }
    assert_redirected_to timeslot_url(@timeslot)
  end

  test "should destroy timeslot" do
    assert_difference('Timeslot.count', -1) do
      delete timeslot_url(@timeslot)
    end

    assert_redirected_to timeslots_url
  end
end
