class Client < ApplicationRecord
  validates(:name, presence: true, uniqueness: true)
  has_many :students, :dependent => :destroy
end
