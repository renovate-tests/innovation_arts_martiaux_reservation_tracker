class ApplicationMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings[:enable_starttls_auto] = false
  ActionMailer::Base.raise_delivery_errors = true
  default from: 'innovationartsmartiaux@hotmail.ca'
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
      address:              'smtp.sendgrid.net',
      port:                 587,
      domain:               'innovationartsmartiaux.com',
      password: ENV['SENDGRID_PASSWORD'],
      user_name: ENV['SENDGRID_USERNAME'],
      authentication:       'plain',
      enable_starttls_auto: true
  }
  layout 'mailer'
end
