class ChargesController < ApplicationController
  before_action :user_is_admin_or_logged_in
  before_action :set_charge, only: [:new]
  before_action :user_is_owner_or_admin, only: [:new, :create]

  def index
    if current_admin
      @unpaid_reservations = Reservation.joins('INNER JOIN students s on reservations.student_id = s.id
                                              INNER JOIN users u on s.user_id = u.id
                                              INNER JOIN courses c on reservations.course_id = c.id
                                              INNER JOIN course_types ct on c.course_type_id = ct.id
                                              INNER JOIN age_groups a on c.age_group_id = a.id
                                              INNER JOIN timeslots t on c.timeslot_id = t.id
                                              LEFT JOIN reservation_charges_tracking rct on reservations.id = rct.reservation_id').where(['rct.paid is null']).select('ct.name as course_name,
                                              reservations.id, s.name as student_name, a.name as age_group, t.start_time, t.end_time, c.day_of_week, u.name as client_name, rct.paid')

      @paid_reservations = Reservation.joins('INNER JOIN students s on reservations.student_id = s.id
                                              INNER JOIN users u on s.user_id = u.id
                                              INNER JOIN courses c on reservations.course_id = c.id
                                              INNER JOIN course_types ct on c.course_type_id = ct.id
                                              INNER JOIN age_groups a on c.age_group_id = a.id
                                              INNER JOIN timeslots t on c.timeslot_id = t.id
                                              LEFT JOIN reservation_charges_tracking rct on reservations.id = rct.reservation_id').where(['rct.paid = true']).select('ct.name as course_name,
                                              reservations.id, s.name as student_name, a.name as age_group, t.start_time, t.end_time, c.day_of_week, u.name as client_name, rct.paid')

    else
      @unpaid_reservations = Reservation.joins('INNER JOIN students s on reservations.student_id = s.id
                                              INNER JOIN users u on s.user_id = u.id
                                              INNER JOIN courses c on reservations.course_id = c.id
                                              INNER JOIN course_types ct on c.course_type_id = ct.id
                                              INNER JOIN age_groups a on c.age_group_id = a.id
                                              INNER JOIN timeslots t on c.timeslot_id = t.id
                                              LEFT JOIN reservation_charges_tracking rct on reservations.id = rct.reservation_id').where(['u.id = ? and rct.paid is null', current_user]).select('ct.name as course_name,
                                              reservations.id, s.name as student_name, a.name as age_group, t.start_time, t.end_time, c.day_of_week, u.name as client_name, rct.paid')

      @paid_reservations = Reservation.joins('INNER JOIN students s on reservations.student_id = s.id
                                              INNER JOIN users u on s.user_id = u.id
                                              INNER JOIN courses c on reservations.course_id = c.id
                                              INNER JOIN course_types ct on c.course_type_id = ct.id
                                              INNER JOIN age_groups a on c.age_group_id = a.id
                                              INNER JOIN timeslots t on c.timeslot_id = t.id
                                              LEFT JOIN reservation_charges_tracking rct on reservations.id = rct.reservation_id').where(['u.id = ? and rct.paid = true', current_user]).select('ct.name as course_name,
                                              reservations.id, s.name as student_name, a.name as age_group, t.start_time, t.end_time, c.day_of_week, u.name as client_name, rct.paid')
    end
  end

  def new

    if params[:reservation] == 'all'
      @reservations_to_pay = Reservation.joins('INNER JOIN students s on reservations.student_id = s.id
      INNER JOIN users u on s.user_id = u.id
      INNER JOIN courses c on reservations.course_id = c.id
      LEFT JOIN reservation_charges_tracking rct on reservations.id = rct.reservation_id').where(['u.id = ? and rct.paid is null', current_user]).select('reservations.id')
      @reservation_details = {
          course_price: 1275 * @reservations_to_pay.count,
          reservation: 'all'
      }


    else
      @reservation_details = {
          course_price: 1275,
          reservation: params[:reservation]
      }
    end
  end

  def create
    # Amount in cents
    @amount = params[:amount]
    customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source => params[:stripeToken]
    )

    @charge = Stripe::Charge.create(
        :customer => customer.id,
        :amount => @amount,
        :description => 'Payment for courses',
        :currency => 'CAD'
    )

    if params[:reservation] == 'all'
      @reservations_to_pay = Reservation.joins('INNER JOIN students s on reservations.student_id = s.id
      INNER JOIN users u on s.user_id = u.id
      INNER JOIN courses c on reservations.course_id = c.id
      LEFT JOIN reservation_charges_tracking rct on reservations.id = rct.reservation_id').where(['u.id = ? and rct.paid is null', current_user]).select('reservations.id, students.user_id as student_user_id')
      @reservations_to_pay.each do |reservation|
        update_reservation_query = ActiveRecord::Base::sanitize_sql(['insert into reservation_charges_tracking (reservation_id, user_id, charge_id, paid) values (?, ?, ?, ?)', reservation.id, reservation.student_user_id, @charge.id, true])
        @charge_paid = ActiveRecord::Base.connection.execute(update_reservation_query)
      end
    else
      @reservation_details_after_processing = params[:reservation].to_i
      @reservations_to_pay = Reservation.joins('INNER JOIN students s on reservations.student_id = s.id
                                                INNER JOIN users u on s.user_id = u.id').select('reservations.id, s.id as student_id, u.id as user_id').find(@reservation_details_after_processing)

      update_reservation_query = ActiveRecord::Base::sanitize_sql(['insert into reservation_charges_tracking (reservation_id, user_id, charge_id, paid) values (?, ?, ?, ?)', params[:reservation], @reservations_to_pay.user_id, @charge.id, true])
      @charge_paid = ActiveRecord::Base.connection.execute(update_reservation_query)
    end


  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end


  private

  def set_charge
    redirect_to charges_path unless params[:reservation]
  end

  def user_is_owner_or_admin
    return if current_admin
    if params[:reservation] == 'all'
      redirect_to charges_path if Reservation.joins('INNER JOIN students s on reservations.student_id = s.id
                                              INNER JOIN users u on s.user_id = u.id
                                              INNER JOIN courses c on reservations.course_id = c.id
                                              INNER JOIN course_types ct on c.course_type_id = ct.id
                                              INNER JOIN age_groups a on c.age_group_id = a.id
                                              INNER JOIN timeslots t on c.timeslot_id = t.id
                                              LEFT JOIN reservation_charges_tracking rct on reservations.id = rct.reservation_id').where(['u.id = ? and rct.paid is null', current_user]).select('ct.name as course_name,
                                              reservations.id, s.name as student_name, a.name as age_group, t.start_time, t.end_time, c.day_of_week, u.name as client_name, rct.paid').empty?
    else
      query = ActiveRecord::Base.sanitize_sql("SELECT students.user_id FROM reservations
                                                        INNER JOIN students on reservations.student_id = students.id
                                                        WHERE (reservations.id = #{params[:reservation]})")
      value = ActiveRecord::Base.connection.execute(query).values[0][0]
      redirect_to charges_path unless value == current_user.id
    end

  end

end
