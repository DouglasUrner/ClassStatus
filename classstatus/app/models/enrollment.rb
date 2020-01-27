class Enrollment < ApplicationRecord
  belongs_to :student
  belongs_to :section
  
  enum status: { active: 0, dropped: 1 }
end
