module ApplicationHelper
  def alternate_locales
    I18n.available_locales.map {|l|
      yield(l)
    }.join.html_safe
  end

  def get_week_day(a_day)
    a_day
    days_list = []
    Date::DAYNAMES.each do |day|
      days_list << day
    end
    days_list[a_day]
  end

  def get_latest_belt_color(a_student)
    result = Graduation.where(student_id: a_student).joins('INNER JOIN belts b on graduations.belt_id = b.id').order('graduation_date desc').limit(1).to_a
    result.empty? ? 'White' : Belt.joins('INNER JOIN graduations g on g.belt_id = belts.id').find(result[0].belt_id).color
  end


  def get_months_since_last_graduations(a_student)
    last_graduation_date = Graduation.where(student_id: a_student).order('graduation_date desc').limit(1).to_a
    if last_graduation_date.empty?
      student_creation_date = Student.where(id: a_student).to_a.first
      Date.parse(student_creation_date.created_at.to_s).upto(Date.today).count.fdiv(30).round(2)
    else
      last_graduation_date[0].graduation_date.upto(Date.today).count.fdiv(30).round(2)
    end

  end


  def get_places_used(a_course)
    Reservation.where(active: true, course_id: a_course).count
  end

  def get_susbcribed_students(a_course)
    Reservation.joins('left join students s on reservations.student_id = s.id
                       left join users u on s.user_id = u.id').where('reservations.course_id =?
                                                                            and reservations.active = true', a_course).select('s.id, s.name,
                                                                            u.name as client_name,
                                                                            s.trial_class,
                                                                            s.uniform_promotion').to_a

  end


  def calculate_age(a_date)
    a_date.upto(Date.today).count.fdiv(365).round(1) unless a_date.nil?
  end

end
