class Graduation < ApplicationRecord
  validates :student_id, presence: true, uniqueness: {scope: :belt_id}
  validates :belt_id, presence: true

  belongs_to :student
  belongs_to :belt

end
