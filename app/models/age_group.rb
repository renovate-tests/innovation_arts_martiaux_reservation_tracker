class AgeGroup < ApplicationRecord
  validates :name, presence: true, uniqueness: {scopes: [:min_age, :max_age]}
  validates :min_age, presence: true, numericality: true
  validates :max_age, presence: true, numericality: true
end
