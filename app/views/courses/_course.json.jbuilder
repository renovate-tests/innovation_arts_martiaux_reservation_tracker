json.extract! course, :id, :course_type_id, :timeslot_id, :number_of_students_allowed, :day_of_week, :created_at, :updated_at
json.url course_url(course, format: :json)
