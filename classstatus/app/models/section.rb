class Section < ApplicationRecord
  belongs_to :course
  has_many :enrollments
  has_many :students, through: :enrollments
end
