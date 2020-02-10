require "application_system_test_case"

class StudentsTest < ApplicationSystemTestCase
  setup do
    @student = students(:one)
  end

  test "visiting the index" do
    visit students_url
    assert_selector "h1", text: "Students"
  end

  test "creating a Student" do
    visit students_url
    click_on "New Student"

    fill_in "Cohort", with: @student.cohort
    fill_in "Dob", with: @student.dob
    fill_in "Family name", with: @student.family_name
    fill_in "Gender", with: @student.gender
    fill_in "Given name", with: @student.given_name
    fill_in "Gpa", with: @student.gpa
    fill_in "Gpa updated", with: @student.gpa_updated
    fill_in "Guid", with: @student.guid
    fill_in "Preferred name", with: @student.preferred_name
    fill_in "Pronouns", with: @student.pronouns
    click_on "Create Student"

    assert_text "Student was successfully created"
    click_on "Back"
  end

  test "updating a Student" do
    visit students_url
    click_on "Edit", match: :first

    fill_in "Cohort", with: @student.cohort
    fill_in "Dob", with: @student.dob
    fill_in "Family name", with: @student.family_name
    fill_in "Gender", with: @student.gender
    fill_in "Given name", with: @student.given_name
    fill_in "Gpa", with: @student.gpa
    fill_in "Gpa updated", with: @student.gpa_updated
    fill_in "Guid", with: @student.guid
    fill_in "Preferred name", with: @student.preferred_name
    fill_in "Pronouns", with: @student.pronouns
    click_on "Update Student"

    assert_text "Student was successfully updated"
    click_on "Back"
  end

  test "destroying a Student" do
    visit students_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Student was successfully destroyed"
  end
end
