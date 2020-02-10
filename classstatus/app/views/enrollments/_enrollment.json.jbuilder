json.extract! enrollment, :id, :student_id, :section_id, :joined_course, :joined_section, :dropped_course, :created_at, :updated_at
json.url enrollment_url(enrollment, format: :json)
