class Course < ApplicationRecord
  validates :name,       presence: true
  validates :short_name, presence: true

  def long_name
    "#{self.name} (#{self.short_name})"
  end
end
