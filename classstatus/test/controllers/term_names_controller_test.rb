require 'test_helper'

class TermNamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @term_name = term_names(:one)
  end

  test "should get index" do
    get term_names_url
    assert_response :success
  end

  test "should get new" do
    get new_term_name_url
    assert_response :success
  end

  test "should create term_name" do
    assert_difference('TermName.count') do
      post term_names_url, params: { term_name: { name: @term_name.name, short_name: @term_name.short_name } }
    end

    assert_redirected_to term_names_url
  end

  test "should show term_name" do
    get term_name_url(@term_name)
    assert_response :success
  end

  test "should get edit" do
    get edit_term_name_url(@term_name)
    assert_response :success
  end

  test "should update term_name" do
    patch term_name_url(@term_name), params: { term_name: { name: @term_name.name, short_name: @term_name.short_name } }
    assert_redirected_to term_names_url
  end

  test "should destroy term_name" do
    assert_difference('TermName.count', -1) do
      delete term_name_url(@term_name)
    end

    assert_redirected_to term_names_url
  end
end
