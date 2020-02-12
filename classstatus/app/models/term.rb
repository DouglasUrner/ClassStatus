class Term < ApplicationRecord
  belongs_to :academic_year
  belongs_to :term_name

  def name
    self.term_name.name
  end

  def short_name
    self.term_name.short_name
  end
end
