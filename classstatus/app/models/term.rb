class Term < ApplicationRecord
  belongs_to :academic_year
  belongs_to :term_name

  def name
    self.term_name.name
  end
end
