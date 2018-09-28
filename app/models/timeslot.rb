class Timeslot < ApplicationRecord
  has_many :courses, foreign_key: 'id'
  validates :start_time, uniqueness: {scope: :end_time}
end
