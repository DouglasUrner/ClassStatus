class Term < ApplicationRecord
  belongs_to :year
  belongs_to :term_name
  validates :start_date, presence: true
  validates :end_date,   presence: true

  def name
    term_name.name
  end

  def short_name
    term_name.short_name
  end
end
