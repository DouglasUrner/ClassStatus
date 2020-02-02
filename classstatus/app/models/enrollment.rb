class Enrollment < ApplicationRecord
  belongs_to :student
  belongs_to :section

  enum state: { active: 'active', dropped: 'dropped' }
end
