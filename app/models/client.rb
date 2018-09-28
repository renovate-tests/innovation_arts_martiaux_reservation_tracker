class Client < ApplicationRecord
  validates(:name, presence: true, uniqueness: true)
  has_many :student, :dependent => :destroy
  has_many :reservation, through: :student

  def self.search(search, page)
    self.where("lower(s.name) LIKE :query", query: "%#{search.downcase}%")
        .paginate(:page => page, :per_page => 10).order('name ASC')
  end

end
