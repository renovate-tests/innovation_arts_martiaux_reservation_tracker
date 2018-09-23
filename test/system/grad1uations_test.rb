require "application_system_test_case"

class GraduationsTest < ApplicationSystemTestCase
  setup do
    @graduation = graduations(:one)
  end

  test "visiting the index" do
    visit graduations_url
    assert_selector "h1", text: "Graduations"
  end

  test "creating a Graduation" do
    visit graduations_url
    click_on "New Graduation"

    fill_in "Belt", with: @graduation.belt_id
    fill_in "Graduation Date", with: @graduation.graduation_date
    fill_in "Student", with: @graduation.student_id
    click_on "Create Graduation"

    assert_text "Graduation was successfully created"
    click_on "Back"
  end

  test "updating a Graduation" do
    visit graduations_url
    click_on "Edit", match: :first

    fill_in "Belt", with: @graduation.belt_id
    fill_in "Graduation Date", with: @graduation.graduation_date
    fill_in "Student", with: @graduation.student_id
    click_on "Update Graduation"

    assert_text "Graduation was successfully updated"
    click_on "Back"
  end

  test "destroying a Graduation" do
    visit graduations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Graduation was successfully destroyed"
  end
end
