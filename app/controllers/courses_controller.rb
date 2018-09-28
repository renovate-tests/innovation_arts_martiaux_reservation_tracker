class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    if params[:search].nil?
      @courses = Course.joins('left join course_types ct on courses.course_type_id = ct.id
                                 left join timeslots t on courses.timeslot_id = t.id
                                 left join age_groups a on courses.age_group_id = a.id').select('courses.id, ct.name as course_type,
                                                                                                 t.start_time, t.end_time, a.name as age_group,
                                                                                                 courses.day_of_week,
                                                                                                 courses.number_of_students_allowed').order('courses.day_of_week, t.start_time').page(params[:page])
    else
      @courses = Course.search(params[:search], params[:page])
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @course = Course.joins('left join course_types ct on courses.course_type_id = ct.id
                                 left join timeslots t on courses.timeslot_id = t.id
                                 left join age_groups a on courses.age_group_id = a.id').select('courses.id, ct.name as course_type,
                                                                                                 t.start_time, t.end_time, a.name as age_group,
                                                                                                 courses.day_of_week,
                                                                                                 courses.number_of_students_allowed').find(params[:id])

    @places_left = @course['number_of_students_allowed'] - Reservation.where(active: true, course_id: params[:id]).count
    @susbcribed_students = Reservation.joins('left join students s on reservations.student_id = s.id
                                              left join clients cl on s.client_id = cl.id').select('s.id, s.name, cl.name as client_name, s.trial_class, s.uniform_promotion').where(course_id: params[:id], active: true)

  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit

  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html {redirect_to @course, notice: 'Course was successfully created.'}
        format.json {render :show, status: :created, location: @course}
      else
        format.html {render :new}
        format.json {render json: @course.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html {redirect_to @course, notice: 'Course was successfully updated.'}
        format.json {render :show, status: :ok, location: @course}
      else
        format.html {render :edit}
        format.json {render json: @course.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html {redirect_to courses_url, notice: 'Course was successfully destroyed.'}
      format.json {head :no_content}
    end
  end


  def courses_list
    @courses_list = Course.joins('left join course_types ct on courses.course_type_id = ct.id
		                              left join timeslots t on courses.timeslot_id = t.id
		                              left join age_groups a on courses.age_group_id = a.id').select('courses.id, courses.day_of_week,
                                                                                                  courses.number_of_students_allowed,
                                                                                                  ct.name, t.start_time,
                                                                                                  t.end_time,
                                                                                                  a.name as age_group').order('courses.day_of_week,
                                                                                                                               t.start_time')
    respond_to do |format|
      format.html {render 'courses/course_list'}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def course_params
    params.require(:course).permit(:course_type_id, :timeslot_id, :number_of_students_allowed, :day_of_week, :age_group_id)
  end


end
