class Reservation < ApplicationRecord
  belongs_to :student, :foreign_key => 'student_id'
  belongs_to :course, :foreign_key => 'course_id'
  validates :student_id, uniqueness:  {scope: :course_id}
end
