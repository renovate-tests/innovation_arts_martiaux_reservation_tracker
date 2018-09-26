class Graduation < ApplicationRecord
  validates :student_id, presence: true
  validates :belt_id, presence: true

  belongs_to :student
  belongs_to :belt

end
