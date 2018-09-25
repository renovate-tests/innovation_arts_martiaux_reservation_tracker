class Reservation < ApplicationRecord
  has_one :course_type, foreign_key: 'id'
  has_one :student, foreign_key: 'id'
end
