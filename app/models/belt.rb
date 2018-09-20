class Belt < ApplicationRecord
  validates(:color, presence: true)
  has_and_belongs_to_many :students
end
