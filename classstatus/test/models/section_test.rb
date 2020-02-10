require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  def setup
    @section = sections(:one)
  end
  
  # test "the truth" do
  #   assert true
  # end

  test 'should get course name for section' do
    section_name = @section.section_name
    assert_equal section_name, 'Section One'
  end
end
