json.extract! student, :id, :guid, :preferred_name, :given_name, :family_name, :pronouns, :gender, :dob, :cohort, :gpa, :gpa_updated, :created_at, :updated_at
json.url student_url(student, format: :json)
