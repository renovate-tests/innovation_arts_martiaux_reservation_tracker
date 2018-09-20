class Client < ApplicationRecord
  validates(:name, presence: true)
  has_many :students, :dependent => :destroy
end
