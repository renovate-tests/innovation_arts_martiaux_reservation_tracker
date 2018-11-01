# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
    address:              'smtp.sendgrid.net',
    port:                 587,
    domain:               'innovationartsmartiaux.com',
    user_name:            InnovationArtsMartiauxReservationsTracker::Application.credentials.SENDGRID_USERNAME,
    password:             InnovationArtsMartiauxReservationsTracker::Application.credentials.SENDGRID_PASSWORD,
    authentication:       'plain',
    enable_starttls_auto: true,
    default from: 'innovationartsmartiaux@hotmail.ca'
}