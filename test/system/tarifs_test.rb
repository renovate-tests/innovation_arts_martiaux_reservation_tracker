require "application_system_test_case"

class TarifsTest < ApplicationSystemTestCase
  setup do
    @tarif = tarifs(:one)
  end

  test "visiting the index" do
    visit tarifs_url
    assert_selector "h1", text: "Tarifs"
  end

  test "creating a Tarif" do
    visit tarifs_url
    click_on "New Tarif"

    fill_in "Class Per Week", with: @tarif.class_per_week
    fill_in "Price", with: @tarif.price
    click_on "Create Tarif"

    assert_text "Tarif was successfully created"
    click_on "Back"
  end

  test "updating a Tarif" do
    visit tarifs_url
    click_on "Edit", match: :first

    fill_in "Class Per Week", with: @tarif.class_per_week
    fill_in "Price", with: @tarif.price
    click_on "Update Tarif"

    assert_text "Tarif was successfully updated"
    click_on "Back"
  end

  test "destroying a Tarif" do
    visit tarifs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tarif was successfully destroyed"
  end
end
