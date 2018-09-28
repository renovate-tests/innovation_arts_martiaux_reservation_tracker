class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  before_action :get_students_list, only: [:new, :create, :edit, :update]
  before_action :get_courses_list, only: [:new, :create, :edit, :update]


  # GET /reservations
  # GET /reservations.json
  def index

    if params[:search].nil?

      @reservations = Reservation.joins('INNER JOIN students s ON s .id = reservations.student_id
                                       INNER JOIN courses c ON c.id = reservations.course_id
                                       INNER JOIN clients cl ON cl.id = s.client_id
                                       INNER JOIN timeslots t on t.id = c.timeslot_id
                                       INNER JOIN course_types ct on ct.id = c.course_type_id
                                       INNER JOIN age_groups a on a.id = c.age_group_id
                                       ').select('s.name as student_name, cl.name as client_name,
                                                  ct.name as course_type, c.day_of_week, t.start_time, t.end_time,
                                                  a.name as age_group, reservations.active, reservations.id').order('reservations.active desc, c.day_of_week, t.start_time, cl.name, ct.name').page(params[:page])

    else
      @reservations = Reservation.search(params[:search], params[:page])
    end
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show

    @reservation = Reservation.joins('INNER JOIN students s ON s .id = reservations.student_id
                                       INNER JOIN courses c ON c.id = reservations.course_id
                                       INNER JOIN clients cl ON cl.id = s.client_id
                                       INNER JOIN timeslots t on t.id = c.timeslot_id
                                       INNER JOIN course_types ct on ct.id = c.course_type_id
                                       INNER JOIN age_groups a on a.id = c.age_group_id
                                       ').select('s.name as student_name, cl.name as client_name,
                                                  ct.name as course_type, c.day_of_week, t.start_time, t.end_time,
                                                  a.name as age_group, reservations.active, reservations.id').find(params[:id])
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit

  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)
    respond_to do |format|
      if @reservation.save
        format.html {redirect_to @reservation, notice: 'Reservation was successfully created.'}
        format.json {render :show, status: :created, location: @reservation}
      else
        format.html {render :new}
        format.json {render json: @reservation.errors, status: :unprocessable_entity}
      end
    end
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def get_students_list
    @students = Student.joins('INNER JOIN clients cl on cl.id = students.client_id').select('students.id as student_id, students.name, cl.id, cl.name as client_name').where('students.active = true').order('cl.name, students.name')
  end

  def get_courses_list
    @courses = Course.joins('left join course_types ct on courses.course_type_id = ct.id
                             left join timeslots t on courses.timeslot_id = t.id
                             left join age_groups a on courses.age_group_id = a.id').select('courses.id, ct.id as course_type_id,
                                                                                             ct.name as course_type, t.start_time,
                                                                                             t.end_time, courses.day_of_week,
                                                                                             a.name as age_group').order('courses.day_of_week, t.start_time')
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def reservation_params
    params.require(:reservation).permit(:student_id, :course_id, :active)
  end
end
