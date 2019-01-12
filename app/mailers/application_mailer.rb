class ApplicationMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)
  if Rails.env == 'development'
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings[:enable_starttls_auto] = false
    ActionMailer::Base.raise_delivery_errors = true
    default from: 'innovationartsmartiaux@hotmail.ca'
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
        address: 'localhost',
        port: 25,
        domain: 'innovationartsmartiaux.ca',
        authentication: 'none',
        enable_starttls_auto: true
    }

  else
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings[:enable_starttls_auto] = false
    ActionMailer::Base.raise_delivery_errors = true
    default from: 'innovationartsmartiaux@hotmail.ca'
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
        address: 'smtp.sendgrid.net',
        port: 587,
        domain: 'innovationartsmartiaux.ca',
        password: ENV['SENDGRID_PASSWORD'],
        user_name: ENV['SENDGRID_USERNAME'],
        authentication: 'plain',
        enable_starttls_auto: true
    }
  end

  layout 'mailer'
end
