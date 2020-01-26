class Term < ApplicationRecord
  belongs_to :year
  belongs_to :term_name
  validates :start_date, presence: true
  validates :end_date,   presence: true
end
