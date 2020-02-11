class Section < ApplicationRecord
  belongs_to :course
  belongs_to :academic_year
  belongs_to :term
  belongs_to :block

  def name
    self.short_name
  end

  def long_name
    "#{self.course_name}"
  end

  def short_name
    "#{self.course_name} (#{self.block_name})"
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

  def year_name
    self.academic_year.name
  end
end
