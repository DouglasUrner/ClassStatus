require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @student1 = students(:one)
    @student2 = students(:two)
  end

  test 'name should be full name' do
    assert_equal @student1.name, @student1.full_name
  end

  test 'should generate full name' do
    assert_equal 'Given1 Family1', @student1.full_name
  end

  test 'should generate sortable name' do
    assert_equal 'Family1, Given1', @student1.sortable_name
  end

  test 'should generate short name' do
    assert_equal 'Given1 F.', @student1.short_name
  end

  test 'should generate initials' do
    assert_equal 'GF', @student1.initials
  end

  test 'should choose preferred name over given name' do
    assert_equal 'Preferred2', @student2.preferred_or_given_name
  end
end
