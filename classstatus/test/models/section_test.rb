require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  def setup
    @section = sections(:one)
  end

  test 'should get academic year for section' do
    year_name = @section.year_name
    assert_equal '1', year_name
  end

  test 'should get block name for section' do
    block_name = @section.block_name
    assert_equal 'A1', block_name
  end

  test 'should get course name for section' do
    course_name = @section.course_name
    assert_equal 'Course One', course_name
  end

  test 'should get term name for section' do
    term_name = @section.term_name
    assert_equal 'Term 1', term_name
  end

  test 'name should be the short name of the section' do
    assert_equal @section.short_name, @section.name
  end

  test 'should get long name for section' do
    assert_equal 'Course One ()', @section.long_name
  end

  test 'should get the short name for the section' do
    assert_equal 'Course One (A1)', @section.short_name
  end
end
