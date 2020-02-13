class Section < ApplicationRecord
  belongs_to :course
  belongs_to :academic_year
  belongs_to :term
  belongs_to :block

  has_many :enrollments, inverse_of: :section, dependent: :destroy
  accepts_nested_attributes_for :enrollments
  has_many :students, through: :enrollments

  def name
    self.short_name
  end

  def long_name
    "#{self.short_name} (#{self.term_short_name} - #{self.year_name})"
  end

  def short_name
    "#{self.block_name}: #{self.course_name}"
  end

  def block_name
    self.block.name
  end

  def course_name
    self.course.name
  end

  def term_name
    self.term.name
  end

  def term_short_name
    self.term.short_name
  end

  def year_name
    self.academic_year.name
  end
end
