require "application_system_test_case"

class AcademicYearsTest < ApplicationSystemTestCase
  setup do
    @academic_year = academic_years(:one)
  end

  test "visiting the index" do
    visit academic_years_url
    assert_selector "h1", text: "Academic Years"
  end

  test "creating a Academic year" do
    visit academic_years_url
    click_on "New Academic Year"

    fill_in "Name", with: @academic_year.name
    click_on "Create Academic year"

    assert_text "Academic year was successfully created"
    click_on "Back"
  end

  test "updating a Academic year" do
    visit academic_years_url
    click_on "Edit", match: :first

    fill_in "Name", with: @academic_year.name
    click_on "Update Academic year"

    assert_text "Academic year was successfully updated"
    click_on "Back"
  end

  test "destroying a Academic year" do
    visit academic_years_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Academic year was successfully destroyed"
  end
end
