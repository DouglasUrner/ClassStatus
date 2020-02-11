class Student < ApplicationRecord
  def name
    self.full_name
  end

  def full_name
    "#{self.preferred_or_given_name} #{self.family_name}"
  end

  def sortable_name
    "#{self.family_name}, #{self.preferred_or_given_name}"
  end

  def short_name
    "#{self.preferred_or_given_name} #{self.family_name[0]}."
  end

  def initials
    "#{self.preferred_or_given_name[0]}#{self.family_name[0]}"
  end

  def preferred_or_given_name
    self.preferred_name ? self.preferred_name : self.given_name
  end
end
