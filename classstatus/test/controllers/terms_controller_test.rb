require 'test_helper'

class TermsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @term = terms(:one)
  end

  test "should get index" do
    get terms_url
    assert_response :success
  end

  test "should get new" do
    get new_term_url
    assert_response :success
  end

  test "should create term" do
    assert_difference('Term.count') do
      post terms_url, params: { term: { academic_years_id: @term.academic_years_id, end_date: @term.end_date, start_date: @term.start_date, term_names_id: @term.term_names_id } }
    end

    assert_redirected_to term_url(Term.last)
  end

  test "should show term" do
    get term_url(@term)
    assert_response :success
  end

  test "should get edit" do
    get edit_term_url(@term)
    assert_response :success
  end

  test "should update term" do
    patch term_url(@term), params: { term: { academic_years_id: @term.academic_years_id, end_date: @term.end_date, start_date: @term.start_date, term_names_id: @term.term_names_id } }
    assert_redirected_to term_url(@term)
  end

  test "should destroy term" do
    assert_difference('Term.count', -1) do
      delete term_url(@term)
    end

    assert_redirected_to terms_url
  end
end
