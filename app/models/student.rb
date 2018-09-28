class Student < ApplicationRecord
  validates(:name, presence: true, uniqueness: {scope: :client_id})
  has_many :graduation, foreign_key: 'student_id', :dependent => :destroy
  has_many :reservation, foreign_key: 'student_id', :dependent => :destroy
end
