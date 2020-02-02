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
  def attendance_stats(s)
    days   = AttendanceRecord.where(student_id: id, section_id: s)
    absent = days.where(state: AttendanceRecord.states[:absent])
    tardy  = days.where(state: AttendanceRecord.states[:tardy])

    "Days: #{days.count}; Absent: #{absent.count}; Tardy: #{tardy.count}"
  end

  def overall_absence_rate(s)
    days = AttendanceRecord.where(student_id: id, section_id: s)
    absent = days.where(state: AttendanceRecord.states[:absent])
    if (days.count > 0)
      absent.count / days.count
    else
      -1
    end
  end

  # Number of absences in the last n classes.
  def recent_absences(s, n)
    days = AttendanceRecord.where(student_id: id, section_id: s)
    days.where(state: AttendanceRecord.states[:absent]).count
  end
end
