class Course < ApplicationRecord
  has_one :course_type, foreign_key: 'id'
  has_one :timeslot, foreign_key: 'id'
  has_one :age_group, foreign_key: 'id'

  validates :course_type_id, presence: true
  validates :age_group_id, presence: true
  validates :timeslot_id, presence: true
  validates :number_of_students_allowed, presence: true
end
