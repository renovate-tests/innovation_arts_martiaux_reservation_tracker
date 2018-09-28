class Student < ApplicationRecord
  validates(:name, presence: true, uniqueness: {scope: :client_id})
  has_many :graduation, foreign_key: 'student_id', :dependent => :destroy
  has_many :reservation, foreign_key: 'student_id', :dependent => :destroy

  def self.search(search, page)
    self.where("lower(name) LIKE :query", query: "%#{search.downcase}%").paginate(:page => page, :per_page => 10).order('name ASC')
  end
end
