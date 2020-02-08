class AttendanceRecord < ApplicationRecord
  belongs_to :student
  belongs_to :section

  enum primary: {
    # Can't use 'present' because it's a Rails keyword.
    in_class:   'in_class',
    absent:     'absent',
    tardy:      'tardy',
    tardy_10:   'tardy10',
  }

  # Secondary attendance states can coexist with the primary states.
  enum seconday: {
    called_out: 'called_out',
    tardy_lunch: 'tardy_lunch',
    absent_lunch: 'absent_lunch'
  }

  def state
    primary
  end

  def attendance_entered
    created_at
  end

  def attendance_updated
    updated_at
  end

  # Normalize bulk attendance records from a section attendance posting.
  def normalize_attendance_record
    enrollments = Enrollment.where(section_id: params[:section_id])
    enrollments.each do |e|
      if (params["ar-#{e.student_id}"])
        state = params["ar-#{e.student_id}"]
        ar_params = {}
        ar_params[:student_id] = e.student_id
        ar_params[:section_id] = params['section_id']
        ar_params[:attendance_date] = Date.today
        ar_params[:primary] = primary
        ar_params[:seconday] = secondary
        #puts ar_params
        # At this point we have a "normal" attendance_record submission and
        # can hand it off to attendance_records#create where it will be checked
        # for duplication (e.g., updating attendance) and then commited to the
        # database as a new or updated record. The parameters are checked in
        # attendance_records#create.
        AttendanceRecord.create(ar_params)
      end
    end
  end
end
