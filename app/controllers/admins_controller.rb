class AdminsController < ApplicationController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]
  before_action :user_is_admin

  def index
    @admins = Admin.all.page(params[:page])
    respond_to do |format|
      format.html
      format.csv {send_data admin.all.to_csv}
    end
  end


  def show

  end

  def edit
  end


  def update


    respond_to do |format|
      if @admin.update(admin_params)
        format.html {redirect_to @admin, notice: 'Admin.was successfully updated.'}
        format.json {render :show, status: :ok, location: @admin}
      else
        format.html {render :edit}
        format.json {render json: @admin.errors, status: :unprocessable_entity}
      end
    end
  end


  def destroy
    @admin.destroy
    respond_to do |format|
      format.html {redirect_to admin_url, notice: 'Admin.was successfully destroyed.'}
      format.json {head :no_content}
    end
  end


  def aditionnal_admins

    @admin = Admin.new

    respond_to do |format|
      format.html
    end
  end

  private


  # Use callbacks to share common setup or constraints between actions.
  def set_admin
    @admin = Admin.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def Admin.params
    params.require(:admin.permit(:name, :email, :telephone, :active, :password, :password_confirm))
  end

end
