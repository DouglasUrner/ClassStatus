require 'test_helper'

class SectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @section = sections(:one)
  end

  test "should get index" do
    get sections_url
    assert_response :success
  end

  test "should get new" do
    get new_section_url
    assert_response :success
  end

  test "should create section" do
    assert_difference('Section.count') do
      post sections_url, params: { section: { academic_year_id: @section.academic_year_id, block_id: @section.block_id, course_id: @section.course_id, term_id: @section.term_id } }
    end

    assert_redirected_to sections_url
  end

  test "should show section" do
    get section_url(@section)
    assert_response :success
  end

  test "should get edit" do
    get edit_section_url(@section)
    assert_response :success
  end

  test "should update section" do
    patch section_url(@section), params: { section: { academic_year_id: @section.academic_year_id, block_id: @section.block_id, course_id: @section.course_id, term_id: @section.term_id } }
    assert_redirected_to sections_url
  end

  test "should destroy section" do
    assert_difference('Section.count', -1) do
      delete section_url(@section)
    end

    assert_redirected_to sections_url
  end
end
