class Section < ApplicationRecord
  belongs_to :course
  belongs_to :year
  belongs_to :term
  belongs_to :block

  def name
    "#{block.name}: #{course.name} (#{term.short_name} #{year.name})"
  end

  def short_name
    "#{block.name}: #{course.name}"
  end
end
