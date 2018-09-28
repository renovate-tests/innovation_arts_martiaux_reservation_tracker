class Graduation < ApplicationRecord
  validates :student_id, presence: true, uniqueness: {scope: :belt_id}
  validates :belt_id, presence: true

  belongs_to :student
  belongs_to :belt

  def self.search(search, page)
    self.joins('INNER JOIN students s on graduations.student_id = s.id
                INNER JOIN belts b on graduations.belt_id = b.id
                INNER JOIN clients cl on s.client_id = cl.id').select('graduations.id, graduations.graduation_date, s.name as name,
                                             b.color as color, cl.name as client_name').where("lower(s.name) LIKE :query", query: "%#{search.downcase}%").paginate(:page => page, :per_page => 10).order('s.name ASC')
  end

end
