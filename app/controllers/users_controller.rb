class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :user_is_admin

  def index

    if params[:search].nil?
      @users = User.all.page(params[:page])
    else
      @users = User.search(params[:search], params[:page]).order('active desc, name')
    end
    respond_to do |format|
      format.html
      format.csv {send_data User.all.to_csv}
    end
  end


  def show

  end

  def edit
  end


  def update

    @students = Student.where(user_id: @user)
    @students.each do| student|
      student.active = user_params[:active]
      student.save
    end
     respond_to do |format|
      if @user.update(user_params)
        format.html {redirect_to @user, notice: 'User was successfully updated.'}
        format.json {render :show, status: :ok, location: @user}
      else
        format.html {render :edit}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end


  def destroy
    @user.destroy
    respond_to do |format|
      format.html {redirect_to users_url, notice: 'User was successfully destroyed.'}
      format.json {head :no_content}
    end
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email, :telephone, :active, :password, :password_confirm)
  end

end
