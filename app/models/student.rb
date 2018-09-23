class Student < ApplicationRecord
  validates(:name, presence: true)
  validates(:belt_id, presence: true)
  belongs_to :client
  has_one :belt
  has_many :graduation, :dependent => :destroy
end
