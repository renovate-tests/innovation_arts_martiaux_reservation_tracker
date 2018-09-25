class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    sql = "select c.id, ct.name as course_type, t.start_time, t.end_time, a.name as age_group, c.day_of_week, c.number_of_students_allowed

             from courses c
                                   left join course_types ct on c.course_type_id = ct.id
                                   left join timeslots t on c.timeslot_id = t.id
                                   left join age_groups a on c.age_group_id = a.id
             order by c.day_of_week, t.start_time"
    @courses = ActiveRecord::Base.connection.execute(sql)
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    sql = "select c.id, ct.name as course_type, t.start_time, t.end_time, a.name as age_group, c.day_of_week, c.number_of_students_allowed

             from courses c
                                   left join course_types ct on c.course_type_id = ct.id
                                   left join timeslots t on c.timeslot_id = t.id
                                   left join age_groups a on c.age_group_id = a.id
            where c.id = #{params[:id]}
            order by c.day_of_week, t.start_time"
    query_results = ActiveRecord::Base.connection.execute(sql)
    query_results.each do |row|
      @course = row
    end
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
