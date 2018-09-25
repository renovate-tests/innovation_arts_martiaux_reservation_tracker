class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  # GET /reservations
  # GET /reservations.json
  def index
    reservation_sql = "select s.name as student_name, cl.name as client_name, ct.name as course_type, c.day_of_week,
                              t.start_time, t.end_time, a.name as age_group, r.active, r.id
                      from reservations r
                            left join students s on r.student_id = s.id
                            left join clients cl on s.client_id = cl.id
                            left join courses c on r.course_id = c.id
                            left join course_types ct on c.course_type_id = ct.id
                            left join timeslots t on c.timeslot_id = t.id
                            left join age_groups a on c.age_group_id = a.id"

    @reservations = ActiveRecord::Base.connection.execute(reservation_sql)
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
    reservation_sql = "select s.name as student_name, cl.name as client_name, ct.name as course_type, c.day_of_week,
                              t.start_time, t.end_time, a.name as age_group, r.active
                      from reservations r
                            left join students s on r.student_id = s.id
                            left join clients cl on s.client_id = cl.id
                            left join courses c on r.course_id = c.id
                            left join course_types ct on c.course_type_id = ct.id
                            left join timeslots t on c.timeslot_id = t.id
                            left join age_groups a on c.age_group_id = a.id
                      where r.id = #{params[:id]}"
    reservation_query_result = ActiveRecord::Base.connection.execute(reservation_sql)
    reservation_query_result.each do |results|
      @reservation = results
    end

  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
    @students = Student.all.includes(:client).where('active = true').order('name')
    course_details_sql = 'select c.id, ct.id as course_type_id, ct.name as course_type, t.start_time, t.end_time, c.day_of_week, a.name as age_group
                            from courses c
                                     left join course_types ct on c.course_type_id = ct.id
                                     left join timeslots t on c.timeslot_id = t.id
                                     left join age_groups a on c.age_group_id = a.id
                            order by c.day_of_week, t.start_time'
    @courses = ActiveRecord::Base.connection.execute(course_details_sql)
  end

  # GET /reservations/1/edit
  def edit
    @students = Student.all.includes(:client).where('active = true').order('name')
    course_type_sql = 'select c.id, ct.id as course_type_id, ct.name as course_type, t.start_time, t.end_time, c.day_of_week, a.name as age_group
                            from courses c
                                     left join course_types ct on c.course_type_id = ct.id
                                     left join timeslots t on c.timeslot_id = t.id
                                     left join age_groups a on c.age_group_id = a.id
                            order by c.day_of_week, t.start_time'
    @courses = ActiveRecord::Base.connection.execute(course_type_sql)
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

  # Never trust parameters from the scary internet, only allow the white list through.
  def reservation_params
    params.require(:reservation).permit(:student_id, :course_id, :active)
  end
end
