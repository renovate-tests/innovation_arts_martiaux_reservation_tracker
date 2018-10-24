class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :set_active_clients, only: [:new, :edit, :create, :update]
  before_action :user_is_admin_or_logged_in
  before_action :user_is_owner_or_admin, only: [:show, :edit, :update, :destroy]
  before_action :user_is_admin, only: [:destroy]


  # GET /students
  # GET /students.json
  def index

    if params[:search].nil?
      if current_admin
        @students = Student.joins('INNER JOIN users u on students.user_id = u.id').select('students.id, students.name,
                                students.date_of_birth, students.active, students.trial_class, students.uniform_promotion,
                                u.name as linked_client').order('students.active desc, linked_client, students.name').page(params[:page])
      else
        @students = Student.joins('INNER JOIN users u on students.user_id = u.id').select('students.id, students.name,
                                students.date_of_birth, students.active, students.trial_class, students.uniform_promotion,
                                u.name as linked_client').where(['students.user_id = ?', current_user.id]).order('students.active desc, linked_client, students.name').page(params[:page])
      end
    else
      if current_admin
        @students = Student.joins('INNER JOIN users u on students.user_id = u.id').select('students.id, students.name,
                                students.date_of_birth, students.active, students.trial_class, students.uniform_promotion,
                                u.name as linked_client').search(params[:search], params[:page])
      else
        @students = Student.where(['students.user_id = ?', current_user.id]).search(params[:search], params[:page])
      end
    end

    respond_to do |format|
      format.html
      if current_admin
        format.csv {send_data Student.joins('INNER JOIN users u on students.user_id = u.id').select('students.id, students.name,
                                                                                             students.date_of_birth, students.active,
                                                                                             students.trial_class, students.uniform_promotion,
                                                                                             u.name as linked_client, u.email, u.telephone').order('students.active desc, linked_client, students.name').to_csv}
      end
    end

  end

  # GET /students/1
  # GET /students/1.json
  def show

    @student = Student.joins('INNER JOIN users u on students.user_id = u.id').select('students.id, students.name, students.date_of_birth, students.active,
                                                                                            students.user_id, students.trial_class, students.uniform_promotion,
                                                                                            u.name as client_name').find(params[:id])
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

  def user_is_owner_or_admin
    redirect_to students_path, notice: 'You do not own this resource' unless current_admin || Student.find(params[:id]).user_id == current_user.id
  end

  def set_active_clients
    @users = User.where('active = ?', true).order('active desc, name')
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def student_params
    params.require(:student).permit(:name, :date_of_birth, :active, :user_id, :trial_class, :uniform_promotion)
  end

  def get_latest_belt_color(a_student)
    result = Graduation.where(student_id: a_student).joins('INNER JOIN belts b on graduations.belt_id = b.id').order('graduation_date desc').limit(1).to_a
    result.empty? ? 'White' : Belt.joins('INNER JOIN graduations g on g.belt_id = belts.id').find(result[0].belt_id).color
  end

end
