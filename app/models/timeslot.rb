class Timeslot < ApplicationRecord
  has_many :courses, foreign_key: 'id'
end
