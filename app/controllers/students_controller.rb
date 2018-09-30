class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :set_active_clients, only: [:new, :edit, :create, :update]

  # GET /students
  # GET /students.json
  def index

    if params[:search].nil?

      @students = Student.joins('INNER JOIN clients cl on students.client_id = cl.id').select('students.id, students.name,
                                                                                             students.date_of_birth, students.active,
                                                                                             students.trial_class, students.uniform_promotion,
                                                                                             cl.name as linked_client').order('students.active desc, linked_client, students.name').page(params[:page])
    else
      @students = Student.search(params[:search], params[:page])
    end

    respond_to do |format|
      format.html
      format.csv { send_data Student.joins('INNER JOIN clients cl on students.client_id = cl.id').select('students.id, students.name,
                                                                                             students.date_of_birth, students.active,
                                                                                             students.trial_class, students.uniform_promotion,
                                                                                             cl.name as linked_client, cl.email, cl.telephone').order('students.active desc, linked_client, students.name').to_csv }
    end

  end

  # GET /students/1
  # GET /students/1.json
  def show

    @student = Student.joins('INNER JOIN clients cl on students.client_id = cl.id').select('students.id, students.name, students.date_of_birth, students.active,
                                                                                            students.client_id, students.trial_class, students.uniform_promotion,
                                                                                            cl.name as client_name').find(params[:id])
    @belt = Graduation.joins('INNER JOIN belts b on graduations.belt_id = b.id
                              INNER JOIN students s on graduations.student_id = s.id').select('b.color').where(student_id: params[:id]).last
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
    @clients = Client.where('active = ?', true).order('active desc, name')
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def student_params
    params.require(:student).permit(:name, :date_of_birth, :active, :client_id, :trial_class, :uniform_promotion)
  end

  def get_latest_belt_color(a_student)
    result = Graduation.where(student_id: a_student).joins('INNER JOIN belts b on graduations.belt_id = b.id').order('graduation_date desc').limit(1).to_a
    result.empty? ? 'White' : Belt.joins('INNER JOIN graduations g on g.belt_id = belts.id').find(result[0].belt_id).color
  end

end
