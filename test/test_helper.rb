ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  module ActionDispatch::Integration
    class Session
      def default_url_options
        { locale: I18n.locale }
      end
    end
  end

end

class ActionView::TestCase::TestController
  def default_url_options options={}
    subject.default_url_options options
  end
end
