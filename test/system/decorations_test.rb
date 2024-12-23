require "application_system_test_case"

class DecorationsTest < ApplicationSystemTestCase
  setup do
    @decoration = decorations(:one)
  end

  test "visiting the index" do
    visit decorations_url
    assert_selector "h1", text: "Decorations"
  end

  test "creating a Decoration" do
    visit decorations_url
    click_on "New Decoration"

    fill_in "Event type", with: @decoration.event_type_id
    fill_in "Name", with: @decoration.name
    click_on "Create Decoration"

    assert_text "Decoration was successfully created"
    click_on "Back"
  end

  test "updating a Decoration" do
    visit decorations_url
    click_on "Edit", match: :first

    fill_in "Event type", with: @decoration.event_type_id
    fill_in "Name", with: @decoration.name
    click_on "Update Decoration"

    assert_text "Decoration was successfully updated"
    click_on "Back"
  end

  test "destroying a Decoration" do
    visit decorations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Decoration was successfully destroyed"
  end
end
