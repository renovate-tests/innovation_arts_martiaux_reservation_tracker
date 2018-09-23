class Graduation < ApplicationRecord
  validates :student_id, presence: true
  validates :belt_id, presence: true

  has_one :student
  has_one :belt

end
