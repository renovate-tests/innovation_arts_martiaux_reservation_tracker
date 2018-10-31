class ApplicationMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings[:enable_starttls_auto] = false
  default from: 'no-reply@invalidmail.com'
  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
      address:              'smtp.gmail.com',
      port:                 587,
      domain:               'example.com',
      user_name:            InnovationArtsMartiauxReservationsTracker::Application.credentials.EMAIL_USER,
      password:             InnovationArtsMartiauxReservationsTracker::Application.credentials.EMAIL_PASS,
      authentication:       'plain',
      enable_starttls_auto: true
  }
  layout 'mailer'
end
