class Enrollment < ApplicationRecord
  belongs_to :student
  belongs_to :section

  # TODO: validations on joined and dropped dates.

  def state
    self.dropped? ? 'Dropped' : 'Active'
  end

  def active?
    if (self.joined_course >= self.section.term.start_date &&
        self.joined_course <= self.section.term.end_date &&
        self.dropped? == false
    )
      true
    else
      false
    end
  end

  def dropped?
    self.dropped_course ? true : false
  end

  def drop!(date = Date.today)
    self.update({dropped_course: date})
  end
end
