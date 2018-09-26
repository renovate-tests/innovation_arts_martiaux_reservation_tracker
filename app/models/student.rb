class Student < ApplicationRecord
  validates(:name, presence: true)
  has_one :belt, foreign_key: 'student_id'
  has_many :graduation, foreign_key: 'student_id', :dependent => :destroy
  has_many :reservation, foreign_key: 'student_id', :dependent => :destroy
end
