class Client < ApplicationRecord
  validates(:name, presence: true, uniqueness: true)
  has_many :student, :dependent => :destroy
  has_many :reservation, through: :student
end
