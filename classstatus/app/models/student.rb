class Student < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :sections, through: :enrollments

  validates :given_name,  presence: true
  validates :family_name, presence: true

  def name
    display_name
  end

  def display_name
    "#{preferred_or_given_name} #{family_name}"
  end

  def short_name
    "#{preferred_or_given_name} #{family_name[0]}."
  end

  def initials
    "#{preferred_or_given_name[0]}#{family_name[0]}"
  end

  def sortable_name
    "#{family_name}, #{preferred_or_given_name}"
  end

  def preferred_or_given_name
    "#{preferred_name.blank? ? given_name : preferred_name}"
  end

  def section_list
    list = ""
    self.sections.each do |s|
      list += "#{s.block.name} "
    end
    list.strip
  end

  # Number of absences and tardies during the life of this section.
  def attendance_stats
    "Absent: 0; Tardy: 0"
  end

  def all_absences
    2
  end

  # Number of absences in the last n classes.
  def recent_absences(n)
    1
  end
end
