class AgeGroup < ApplicationRecord
  validates :name, presence: true
  validates_numericality_of :min_age, :max_age, allow_blank: true
  belongs_to :course, foreign_key: 'age_group_id'
end
