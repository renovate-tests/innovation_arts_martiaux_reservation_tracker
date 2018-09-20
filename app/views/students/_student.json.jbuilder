json.extract! student, :id, :name, :date_of_birth, :active, :created_at, :updated_at
json.url student_url(student, format: :json)
