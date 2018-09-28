class Course < ApplicationRecord
  has_one :course_type, foreign_key: 'id'
  has_one :timeslot, foreign_key: 'id'
  has_one :age_group, foreign_key: 'id'

  validates :course_type_id, presence: true
  validates :age_group_id, presence: true
  validates :timeslot_id, presence: true
  validates :number_of_students_allowed, presence: true

  def self.search(search, page)
    self.joins('left join course_types ct on courses.course_type_id = ct.id
                left join timeslots t on courses.timeslot_id = t.id
                left join age_groups a on courses.age_group_id = a.id').select('courses.id, ct.name as course_type,
                                                                                t.start_time, t.end_time, a.name as age_group,
                                                                                courses.day_of_week,
                                                                                courses.number_of_students_allowed').where("lower(ct.name) LIKE :query", query: "%#{search.downcase}%").paginate(:page => page, :per_page => 10).order('ct.name')
  end

end
