class CourseType < ApplicationRecord
  def self.search(search, page)
    self.where("lower(name) LIKE :query", query: "%#{search.downcase}%").paginate(:page => page, :per_page => 10).order('name ASC')
  end
end
