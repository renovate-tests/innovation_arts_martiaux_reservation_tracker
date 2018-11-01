class ApplicationMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings[:enable_starttls_auto] = false
  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
      address:              'smtp.sendgrid.net',
      port:                 587,
      domain:               'innovationartsmartiaux.com',
      user_name:            InnovationArtsMartiauxReservationsTracker::Application.credentials.SENDGRID_USERNAME,
      password:             InnovationArtsMartiauxReservationsTracker::Application.credentials.SENDGRID_PASSWORD,
      authentication:       'plain',
      enable_starttls_auto: true,
      default from: 'innovationsartsmartiaux@hotmail.ca'
  }
  layout 'mailer'
end
