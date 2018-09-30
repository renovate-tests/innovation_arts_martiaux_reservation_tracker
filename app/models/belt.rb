class Belt < ApplicationRecord
  validates(:color, presence: true, uniqueness: true)
end
