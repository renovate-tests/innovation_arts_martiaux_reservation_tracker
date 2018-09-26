class Timeslot < ApplicationRecord
  has_many :courses, foreign_key: 'id'
  belongs_to :reservations, foreign_key: 'id'
end
