class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :set_active_clients, only: [:new, :edit, :create, :update]

  # GET /students
  # GET /students.json
  def index
    sql = 'select s.id, s.name, s.date_of_birth, s.active, s.trial_class, s.uniform_promotion, c.name as linked_client
                  from students s
                       left join clients c on c.id = s.client_id'
    @students = ActiveRecord::Base.connection.execute(sql)
  end

  # GET /students/1
  # GET /students/1.json
  def show
    student_query_sql = "select s.id, s.name, s.date_of_birth, s.active, b.color as belt_color, cl.name as linked_client, s.trial_class, s.uniform_promotion
                         from students s
                              left join graduations g on g.student_id = s.id
                              left join belts b on g.belt_id = b.id
                              left join clients cl on s.client_id = cl.id
                          where
                              graduation_date = (select max(graduation_date) from graduations where student_id = #{params[:id]})
                              and s.id = #{params[:id]}"
    query_results = ActiveRecord::Base.connection.execute(student_query_sql)
    query_results.each do |results|
      @student = results
    end
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)
    respond_to do |format|
      if @student.save
        format.html {redirect_to @student, notice: 'Student was successfully created.'}
        format.json {render :show, status: :created, location: @student}
      else
        format.html {render :new}
        format.json {render json: @student.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html {redirect_to @student, notice: 'Student was successfully updated.'}
        format.json {render :show, status: :ok, location: @student}
      else
        format.html {render :edit}
        format.json {render json: @student.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html {redirect_to students_url, notice: 'Student was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = Student.find(params[:id])
  end


  def set_active_clients
    @clients = Client.where('active = ?', true)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def student_params
    params.require(:student).permit(:name, :date_of_birth, :active, :client_id, :trial_class, :uniform_promotion)
  end

  def get_latest_belt_color(a_student)
    belt_query = "select b.color from graduations g left join belts b on g.belt_id = b.id where graduation_date = (select max(graduation_date) from graduations where student_id = #{a_student})"
    query_results = ActiveRecord::Base.connection.execute(belt_query)
    query_results.each do |query_results|
      query_results['color']
    end
  end

end
