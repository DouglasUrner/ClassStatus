require "application_system_test_case"

class TermNamesTest < ApplicationSystemTestCase
  setup do
    @term_name = term_names(:one)
  end

  test "visiting the index" do
    visit term_names_url
    assert_selector "h1", text: "Term Names"
  end

  test "creating a Term name" do
    visit term_names_url
    click_on "New Term Name"

    fill_in "Name", with: @term_name.name
    fill_in "Short name", with: @term_name.short_name
    click_on "Create Term name"

    assert_text "Term name was successfully created"
    click_on "Back"
  end

  test "updating a Term name" do
    visit term_names_url
    click_on "Edit", match: :first

    fill_in "Name", with: @term_name.name
    fill_in "Short name", with: @term_name.short_name
    click_on "Update Term name"

    assert_text "Term name was successfully updated"
    click_on "Back"
  end

  test "destroying a Term name" do
    visit term_names_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Term name was successfully destroyed"
  end
end
