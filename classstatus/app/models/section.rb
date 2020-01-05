class Section < ApplicationRecord
  belongs_to :course
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments
end
