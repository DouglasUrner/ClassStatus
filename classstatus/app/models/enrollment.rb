class Enrollment < ApplicationRecord
  belongs_to :student
  belongs_to :section

  def name
    self.section.name
  end

  def short_name
    self.section.abbreviated_name
  end

end
