class RegistrationsController < Devise::RegistrationsController
  include Accessible
  skip_before_action :check_user, except: [:new, :create]

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :telephone)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :telephone)
  end
end