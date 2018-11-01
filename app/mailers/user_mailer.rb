class UserMailer < ApplicationMailer
  def send_new_user_message(params)
    @user = params
    # mail(to: @user.email, subject: "Nouveau client: #{params.email}", cc: 'sheldreyn@gmail.com')
    mail(to: 'innovationartsmartiaux@hotmail.ca', subject: "Nouveau client: #{params.email}", bcc: 'sheldreyn@gmail.com')
  end

  def send_new_reservation_message(params)
    @reservation = Reservation.joins('INNER JOIN students s ON s .id = reservations.student_id
                                       INNER JOIN courses c ON c.id = reservations.course_id
                                       INNER JOIN users u ON u.id = s.user_id
                                       INNER JOIN timeslots t on t.id = c.timeslot_id
                                       INNER JOIN course_types ct on ct.id = c.course_type_id
                                       INNER JOIN age_groups a on a.id = c.age_group_id
                                       ').select('s.name as student_name, u.name as client_name,
                                                  ct.name as course_type, c.day_of_week, t.start_time, t.end_time,
                                                  a.name as age_group, reservations.active, reservations.id').find(params[:id])
    mail(to: 'innovationartsmartiaux@hotmail.ca', subject: "Nouvelle réservation: #{@reservation['student_name']} - (#{@reservation['client_name']}) ", bcc: 'sheldreyn@gmail.com')
  end

  def send_reservation_confirmed_message(params)
    @reservation = Reservation.joins('INNER JOIN students s ON s .id = reservations.student_id
                                       INNER JOIN courses c ON c.id = reservations.course_id
                                       INNER JOIN users u ON u.id = s.user_id
                                       INNER JOIN timeslots t on t.id = c.timeslot_id
                                       INNER JOIN course_types ct on ct.id = c.course_type_id
                                       INNER JOIN age_groups a on a.id = c.age_group_id
                                       ').select('s.name as student_name, u.name as client_name,
                                                  ct.name as course_type, c.day_of_week, t.start_time, t.end_time,
                                                  a.name as age_group, reservations.active, reservations.id').find(params[:id])
    # mail(to: @user.email, subject: "Nouveau client: #{params.email}", cc: 'sheldreyn@gmail.com')
    #     mail(to: 'sheldreyn@gmail.com', subject: "Nouvelle réservation: #{@reservation['student_name']} - (#{@reservation['client_name']}) ", cc: 'sheldreyn@gmail.com')
    mail(to: 'innovationartsmartiaux@hotmail.ca', subject: "Réservation confirmée: #{@reservation['student_name']} - (#{@reservation['client_name']}) ", bcc: 'sheldreyn@gmail.com')
  end


  def send_reservation_unconfirmed_message(params)
    @reservation = Reservation.joins('INNER JOIN students s ON s .id = reservations.student_id
                                       INNER JOIN courses c ON c.id = reservations.course_id
                                       INNER JOIN users u ON u.id = s.user_id
                                       INNER JOIN timeslots t on t.id = c.timeslot_id
                                       INNER JOIN course_types ct on ct.id = c.course_type_id
                                       INNER JOIN age_groups a on a.id = c.age_group_id
                                       ').select('s.name as student_name, u.name as client_name,
                                                  ct.name as course_type, c.day_of_week, t.start_time, t.end_time,
                                                  a.name as age_group, reservations.active, reservations.id').find(params[:id])
    # mail(to: @user.email, subject: "Nouveau client: #{params.email}", cc: 'sheldreyn@gmail.com')
    #     mail(to: 'sheldreyn@gmail.com', subject: "Nouvelle réservation: #{@reservation['student_name']} - (#{@reservation['client_name']}) ", cc: 'sheldreyn@gmail.com')
    mail(to: 'innovationartsmartiaux@hotmail.ca', subject: "Réservation annulée: #{@reservation['student_name']} - (#{@reservation['client_name']}) ", bcc: 'sheldreyn@gmail.com')
  end

end