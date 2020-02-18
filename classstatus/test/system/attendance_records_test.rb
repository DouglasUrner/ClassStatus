require "application_system_test_case"

class AttendanceRecordsTest < ApplicationSystemTestCase
  setup do
    @attendance_record = attendance_records(:one)
  end

  test "visiting the index" do
    visit attendance_records_url
    assert_selector "h1", text: "Attendance Records"
  end

  test "creating a Attendance record" do
    visit attendance_records_url
    click_on "New Attendance Record"

    fill_in "Attendance date", with: @attendance_record.attendance_date
    fill_in "Marks", with: @attendance_record.marks
    fill_in "Section", with: @attendance_record.section_id
    fill_in "Student", with: @attendance_record.student_id
    click_on "Create Attendance record"

    assert_text "Attendance record was successfully created"
    click_on "Back"
  end

  test "updating a Attendance record" do
    visit attendance_records_url
    click_on "Edit", match: :first

    fill_in "Attendance date", with: @attendance_record.attendance_date
    fill_in "Marks", with: @attendance_record.marks
    fill_in "Section", with: @attendance_record.section_id
    fill_in "Student", with: @attendance_record.student_id
    click_on "Update Attendance record"

    assert_text "Attendance record was successfully updated"
    click_on "Back"
  end

  test "destroying a Attendance record" do
    visit attendance_records_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Attendance record was successfully destroyed"
  end
end
