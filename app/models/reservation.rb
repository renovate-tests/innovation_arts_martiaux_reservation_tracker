class Reservation < ApplicationRecord
  belongs_to :student, :foreign_key => 'student_id'
  belongs_to :course, :foreign_key => 'course_id'
  validates :student_id, uniqueness: {scope: :course_id}
  after_update :send_reservation_confirmed_message

  def self.search(search, page)
    self.joins('INNER JOIN students s ON s .id = reservations.student_id
                INNER JOIN courses c ON c.id = reservations.course_id
                INNER JOIN users u ON u.id = s.user_id
                INNER JOIN timeslots t on t.id = c.timeslot_id
                INNER JOIN course_types ct on ct.id = c.course_type_id
                INNER JOIN age_groups a on a.id = c.age_group_id').select('s.name as student_name, u.name as client_name,
                                                  ct.name as course_type, c.day_of_week, t.start_time, t.end_time,
                                                  a.name as age_group, reservations.active, reservations.id, reservations.mail_sent').order('reservations.active desc,
                c.day_of_week, t.start_time, u.name, ct.name').where("lower(s.name) LIKE :query", query: "%#{search.downcase}%")
        .paginate(:page => page, :per_page => 10).order('u.name, s.name')
  end

  def send_reservation_confirmed_message
    UserMailer.send_reservation_confirmed_message(self).deliver if self.active
  end


end
