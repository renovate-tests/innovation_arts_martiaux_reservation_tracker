json.extract! reservation, :id, :student_id, :course_id, :active, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
