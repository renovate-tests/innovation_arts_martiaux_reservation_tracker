class UserMailer < ApplicationMailer
  def send_new_user_message(params)

    @user = params
   # mail(to: @user.email, subject: "Nouveau client: #{params.email}", cc: 'sheldreyn@gmail.com')
     mail(to: 'sheldreyn@gmail.com', subject: "Nouveau client: #{params.email}", cc: 'sheldreyn@gmail.com')
  end
end