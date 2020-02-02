class Enrollment < ApplicationRecord
  belongs_to :student
  belongs_to :section

  # TODO: validations on joined and dropped dates.

  def state
    self.dropped_course ? 'Dropped' : 'Active'
  end
end
