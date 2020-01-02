class Student < ApplicationRecord
  has_many :sections
  # TODO: validate that at least one is present and length > 2
  validates :given_name, presence: true, length: { minimum: 2 }
  validates :family_name, presence: true, length: { minimum: 2 }
end
