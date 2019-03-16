class TarifsController < ApplicationController
  before_action :set_tarif, only: [:show, :edit, :update, :destroy]
  before_action :user_is_admin


  # GET /tarifs
  # GET /tarifs.json
  def index
    @tarifs = Tarif.all.order(:class_per_week)
  end

  # GET /tarifs/1
  # GET /tarifs/1.json
  def show
  end

  # GET /tarifs/new
  def new
    @tarif = Tarif.new
  end

  # GET /tarifs/1/edit
  def edit
  end

  # POST /tarifs
  # POST /tarifs.json
  def create
    @tarif = Tarif.new(tarif_params)

    respond_to do |format|
      if @tarif.save
        format.html { redirect_to @tarif, notice: 'Tarif was successfully created.' }
        format.json { render :show, status: :created, location: @tarif }
      else
        format.html { render :new }
        format.json { render json: @tarif.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tarifs/1
  # PATCH/PUT /tarifs/1.json
  def update
    respond_to do |format|
      if @tarif.update(tarif_params)
        format.html { redirect_to @tarif, notice: 'Tarif was successfully updated.' }
        format.json { render :show, status: :ok, location: @tarif }
      else
        format.html { render :edit }
        format.json { render json: @tarif.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tarifs/1
  # DELETE /tarifs/1.json
  def destroy
    @tarif.destroy
    respond_to do |format|
      format.html { redirect_to tarifs_url, notice: 'Tarif was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tarif
      @tarif = Tarif.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tarif_params
      params.require(:tarif).permit(:class_per_week, :price, :duration, :uniform_promotion)
    end
end
