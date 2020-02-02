json.extract! attendance_record, :id, :student_id, :section_id, :attendance_date, :attendance_entered, :state, :created_at, :updated_at
json.url attendance_record_url(attendance_record, format: :json)
