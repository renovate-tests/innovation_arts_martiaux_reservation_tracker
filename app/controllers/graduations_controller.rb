class GraduationsController < ApplicationController
  before_action :set_graduation, only: [:show, :edit, :update, :destroy]
  before_action :get_student_list, only: [:new, :edit, :create, :update]


  # GET /graduations
  # GET /graduations.json
  def index
    if params[:search].nil?
      @graduations = Graduation.joins('INNER JOIN students s on graduations.student_id = s.id
                                   INNER JOIN belts b on graduations.belt_id = b.id
                                   INNER JOIN clients cl on s.client_id = cl.id
                                  ').select('graduations.id, graduations.graduation_date, s.name as name,
                                             b.color as color, cl.name as client_name').order('cl.name, s.name, graduations.graduation_date desc').page(params[:page])
    else
      @graduations = Graduation.search(params[:search], params[:page])
    end
  end

  # GET /graduations/1
  # GET /graduations/1.json
  def show
    @graduation = Graduation.joins('INNER JOIN students s on graduations.student_id = s.id
                                   INNER JOIN belts b on graduations.belt_id = b.id
                                   INNER JOIN clients cl on s.client_id = cl.id
                                  ').select('graduations.id, graduations.graduation_date, s.name as name,
                                             b.color as color, cl.name as client_name').find(params[:id])

  end

  # GET /graduations/new
  def new
    @graduation = Graduation.new
  end

  # GET /graduations/1/edit
  def edit
  end

  # POST /graduations
  # POST /graduations.json
  def create
    @graduation = Graduation.new(graduation_params)
    respond_to do |format|
      if @graduation.save
        format.html {redirect_to @graduation, notice: 'Graduation was successfully created.'}
        format.json {render :show, status: :created, location: @graduation}
      else
        format.html {render :new}
        format.json {render json: @graduation.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /graduations/1
  # PATCH/PUT /graduations/1.json
  def update
    respond_to do |format|
      if @graduation.update(graduation_params)
        format.html {redirect_to @graduation, notice: 'Graduation was successfully updated.'}
        format.json {render :show, status: :ok, location: @graduation}
      else
        format.html {render :edit}
        format.json {render json: @graduation.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /graduations/1
  # DELETE /graduations/1.json
  def destroy
    @graduation.destroy
    respond_to do |format|
      format.html {redirect_to graduations_url, notice: 'Graduation was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_graduation
    @graduation = Graduation.find(params[:id])
  end


  def get_student_list
    @students = Student.joins('INNER JOIN clients cl on students.client_id = cl.id').select('students.id, students.name, cl.name as client_name').order('cl.name, students.name')
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def graduation_params
    params.require(:graduation).permit(:student_id, :belt_id, :graduation_date)
  end

end
