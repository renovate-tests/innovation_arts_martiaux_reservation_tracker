module ReservationsHelper

  def reservation_student_is_also_client(reservation_id)
    @reservation = Reservation.joins('INNER JOIN students s ON s .id = reservations.student_id
                                       INNER JOIN courses c ON c.id = reservations.course_id
                                       INNER JOIN users u ON u.id = s.user_id
                                       INNER JOIN timeslots t on t.id = c.timeslot_id
                                       INNER JOIN course_types ct on ct.id = c.course_type_id
                                       INNER JOIN age_groups a on a.id = c.age_group_id
                                       ').select('s.name as student_name, u.name as client_name,
                                                  ct.name as course_type, c.day_of_week, t.start_time, t.end_time,
                                                  a.name as age_group, reservations.active, reservations.id').find(params[:id])

  end


  def unconfirmed_reservations
    @unconfirmed_reservations = Reservation.where('reservations.active = false and reservations.mail_sent = false and reservations.student_id in (select students.id from students where user_id = ?)', current_user.id).count > 0
  end


end
