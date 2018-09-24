class Course < ApplicationRecord
  has_one :course_type, foreign_key: 'id'
  has_one :timeslot, foreign_key: 'id'
  has_one :age_group, foreign_key: 'id'
end
