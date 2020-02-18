json.extract! attendance_record, :id, :section_id, :student_id, :attendance_date, :marks, :created_at, :updated_at
json.url attendance_record_url(attendance_record, format: :json)
