class GraduationsController < ApplicationController
  before_action :set_graduation, only: [:show, :edit, :update, :destroy]

  # GET /graduations
  # GET /graduations.json
  def index
    sql = "select g.id, g.graduation_date, s.name as name, b.color as color from graduations g left join students s on s.id = g.student_id left join belts b on b.id = g.belt_id"
    @graduations = ActiveRecord::Base.connection.execute(sql)
  end

  # GET /graduations/1
  # GET /graduations/1.json
  def show
    sql = "select g.graduation_date, s.name as name, b.color as color from graduations g left join students s on s.id = g.student_id left join belts b on b.id = g.belt_id where g.id = #{params[:id]}"
     @graduation = ActiveRecord::Base.connection.execute(sql)
    @graduation = @graduation[0]
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
        format.html { redirect_to @graduation, notice: 'Graduation was successfully created.' }
        format.json { render :show, status: :created, location: @graduation }
      else
        format.html { render :new }
        format.json { render json: @graduation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /graduations/1
  # PATCH/PUT /graduations/1.json
  def update
    respond_to do |format|
      if @graduation.update(graduation_params)
        format.html { redirect_to @graduation, notice: 'Graduation was successfully updated.' }
        format.json { render :show, status: :ok, location: @graduation }
      else
        format.html { render :edit }
        format.json { render json: @graduation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /graduations/1
  # DELETE /graduations/1.json
  def destroy
    @graduation.destroy
    respond_to do |format|
      format.html { redirect_to graduations_url, notice: 'Graduation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_graduation
      @graduation = Graduation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def graduation_params
      params.require(:graduation).permit(:student_id, :belt_id, :graduation_date)
    end
end
