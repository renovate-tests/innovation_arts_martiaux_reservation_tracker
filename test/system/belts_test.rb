require "application_system_test_case"

class BeltsTest < ApplicationSystemTestCase
  setup do
    @belt = belts(:one)
  end

  test "visiting the index" do
    visit belts_url
    assert_selector "h1", text: "Belts"
  end

  test "creating a Belt" do
    visit belts_url
    click_on "New Belt"

    fill_in "Color", with: @belt.color
    click_on "Create Belt"

    assert_text "Belt was successfully created"
    click_on "Back"
  end

  test "updating a Belt" do
    visit belts_url
    click_on "Edit", match: :first

    fill_in "Color", with: @belt.color
    click_on "Update Belt"

    assert_text "Belt was successfully updated"
    click_on "Back"
  end

  test "destroying a Belt" do
    visit belts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Belt was successfully destroyed"
  end
end
