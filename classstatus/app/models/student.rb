class Student < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :sections, through: :enrollments
  has_many :attendance_records
  accepts_nested_attributes_for :attendance_records

  validates :given_name,  presence: true
  validates :family_name, presence: true

  enum gender: { female: 'F', non_binary: 'X', male: 'M' }

  def compare(old, new)
    false
  end

  # Take the attributes in new and merge (update) them into old. Don't change
  # the values of guid and id (id should be unset and a guid mismatch would be
  # a fatal error. Return a copy of old with updates from new.
  def merge_attributes(new)
    merge = Student.new(attributes).attributes
    new.stringify_keys.each do |key, value|
      case key
      when 'guid' ; puts 'guid: skipped'
      when 'id'   ; puts 'id: skipped'
      when 'gpa'
        merge[key] = value
        merge['gpa_updated'] = DateTime.current
      else
        merge[key] = value if merge.key?(key)
      end
    end
    merge
  end

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

  def get_gender
    case gender
    when 'female'     ; 'F'
    when 'non_binary' ; 'X'
    when 'male'       ; 'M'
    else              ; 'U'
    end
  end

  def get_pronouns
    if pronouns == nil || pronouns == ""
      case get_gender
      when 'F' ; 'she/her (inferred)'
      when 'X' ; 'they/them (inferred)'
      when 'M' ; 'he/him (inferred)'
      when 'U' ; 'unset and unable to infer'
      else     ; puts "PANIC: #{__FILE__}: #{__LINE__}: unknown gender \'#{get_gender}\' for \'#{name}\' (id: #{id})"
      end
    else
      pronouns
    end
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
    all      = AttendanceRecord.where(student_id: id, section_id: s)

    days     = all.count
    absent   = all.where(state: AttendanceRecord.states[:absent]).count
    tardy    = all.where(state: AttendanceRecord.states[:tardy]).count
    tardy10  = all.where(state: AttendanceRecord.states[:tardy10]).count

    "Days: #{days}; Absent: #{absent + tardy10}/#{days}; Tardy: #{tardy}"
  end

  def overall_absence_rate(s)
    days = AttendanceRecord.where(student_id: id, section_id: s)
    absent = days.where(state: AttendanceRecord.states[:absent]) +
      days.where(state: AttendanceRecord.states[:tardy10])
    if (days.count > 0)
      absent.count / days.count
    else
      -1
    end
  end

  # Number of absences in the last n classes.
  def recent_absences(s, n)
    # TODO: limit number of records returned to n.
    days = AttendanceRecord.where(student_id: id, section_id: s)
    days.where(state: AttendanceRecord.states[:absent]).count +
      days.where(state: AttendanceRecord.states[:tardy10]).count
  end
end
