class Student < ApplicationRecord
  validates(:name, presence: true)
  belongs_to :client
  has_one :belt
  has_many :graduation, :dependent => :destroy
end
