class Tarif < ApplicationRecord
  validates_uniqueness_of :class_per_week, scope: :duration
end
