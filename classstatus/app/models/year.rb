class Year < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
