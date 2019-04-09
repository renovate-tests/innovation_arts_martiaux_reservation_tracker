class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  before_action :get_students_list, only: [:new, :create, :edit, :update]
  before_action :get_courses_list, only: [:new, :create, :edit, :update]
  before_action :user_is_admin_or_logged_in
  before_action :user_is_admin, only: [:edit, :update, :destroy]

  # GET /reservations
  # GET /reservations.json
  def index
    @tarifs = Tarif.all.order(:class_per_week)
    if current_admin
      if params[:search].nil?
        @reservations = Reservation.joins('INNER JOIN students s ON s .id = reservations.student_id
                                       INNER JOIN courses c ON c.id = reservations.course_id
                                       INNER JOIN users u ON u.id = s.user_id
                                       INNER JOIN timeslots t on t.id = c.timeslot_id
                                       INNER JOIN course_types ct on ct.id = c.course_type_id
                                       INNER JOIN age_groups a on a.id = c.age_group_id
                                       ').select('s.name as student_name, u.name as client_name,
                                                  ct.name as course_type, c.day_of_week, t.start_time, t.end_time,
                                                  a.name as age_group, reservations.active, reservations.id, reservations.mail_sent, u.id as client_id, reservations.created_at').order(' u.name, s.name, reservations.active, c.day_of_week, t.start_time, ct.name')
      else
        @reservations = Reservation.search(params[:search])
      end
    else
      @reservations = Reservation.joins('INNER JOIN students s ON s .id = reservations.student_id
                                       INNER JOIN courses c ON c.id = reservations.course_id
                                       INNER JOIN users u ON u.id = s.user_id
                                       INNER JOIN timeslots t on t.id = c.timeslot_id
                                       INNER JOIN course_types ct on ct.id = c.course_type_id
                                       INNER JOIN age_groups a on a.id = c.age_group_id
                                       ').where('u.id = ?', current_user).select('s.name as student_name, u.name as client_name,
                                                  ct.name as course_type, c.day_of_week, t.start_time, t.end_time,
                                                  a.name as age_group, reservations.active, reservations.id, reservations.mail_sent, reservations.created_at').order('reservations.active, c.day_of_week, t.start_time, u.name, ct.name')
    end


  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show

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

  # GET /reservations/new
  def new
    @reservation = Reservation.new
    respond_to :js
  end

  # GET /reservations/1/edit
  def edit

  end

  # POST /reservations
  # POST /reservations.json
  def create
    @new_reservation = Reservation.new(reservation_params)
    @new_reservation.save
    @reservation = Reservation.joins('INNER JOIN students s ON s .id = reservations.student_id
                                       INNER JOIN courses c ON c.id = reservations.course_id
                                       INNER JOIN users u ON u.id = s.user_id
                                       INNER JOIN timeslots t on t.id = c.timeslot_id
                                       INNER JOIN course_types ct on ct.id = c.course_type_id
                                       INNER JOIN age_groups a on a.id = c.age_group_id
                                       ').select('s.name as student_name, u.name as client_name,
                                                  ct.name as course_type, c.day_of_week, t.start_time, t.end_time,
                                                  a.name as age_group, reservations.active, reservations.id, u.id as client_id, reservations.mail_sent, reservations.created_at').find(@new_reservation.id)
    respond_to :js
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    @courses = Course.joins('left join course_types ct on courses.course_type_id = ct.id
                             left join timeslots t on courses.timeslot_id = t.id
                             left join age_groups a on courses.age_group_id = a.id').select('courses.id, ct.id as course_type_id, ct.name as course_type, t.start_time, t.end_time, courses.day_of_week, a.name as age_group').order('courses.day_of_week, t.start_time')
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html {redirect_to @reservation, notice: 'Reservation was successfully updated.'}
        format.json {render :show, status: :ok, location: @reservation}
      else
        format.html {render :edit}
        format.json {render json: @reservation.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html {redirect_to reservations_url, notice: 'Reservation was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  def submit_reservations
    @reservations = Reservation.joins('INNER JOIN students on students.id = reservations.student_id INNER JOIN users on users.id = students.user_id').where('users.id = ? and reservations.active = false and reservations.mail_sent = false', current_user[:id])
    @reservations.each do |reservation|
      send_new_reservation_message(reservation)
      ActiveRecord::Base.connection.exec_query("update reservations set mail_sent = true where reservations.id = #{reservation.id}")
      reservation.save
    end
    respond_to do |format|
      format.html {redirect_to reservations_url, notice: 'Reservation was successfully submitted.'}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def get_students_list
    if current_admin
      @students = Student.joins('INNER JOIN users u on u.id = students.user_id').select('students.id as student_id, students.name, u.id, u.name as client_name').where(['students.active = true']).order('u.name, students.name')
    else
      @students = Student.joins('INNER JOIN users u on u.id = students.user_id').select('students.id as student_id, students.name, u.id, u.name as client_name').where(['students.active = true and students.user_id = ?', current_user.id]).order('u.name, students.name')
    end

  end

  def get_courses_list
    @courses = Course.joins('left join course_types ct on courses.course_type_id = ct.id
                             left join timeslots t on courses.timeslot_id = t.id
                             left join age_groups a on courses.age_group_id = a.id').select('courses.id, ct.id as course_type_id,
                                                                                             ct.name as course_type, t.start_time,
                                                                                             t.end_time, courses.day_of_week,
                                                                                             a.name as age_group').order('courses.day_of_week, t.start_time')
  end


  def send_new_reservation_message(a_reservation)
    UserMailer.send_new_reservation_message(a_reservation).deliver
  end


  def send_reservation_confirmed_message
    if self.active
      UserMailer.send_reservation_confirmed_message(self).deliver
    else
      UserMailer.send_reservation_unconfirmed_message(self).deliver
    end
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def reservation_params
    params.require(:reservation).permit(:student_id, :course_id, :active, :mail_sent)
  end
end
