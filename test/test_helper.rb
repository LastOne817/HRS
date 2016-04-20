require 'simplecov'
SimpleCov.start
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:facebook, {
        'provider' => 'facebook',
        'uid' => '123451234512345',
        'info' => {:verified => true, 'email' => 'testuser@testmail.com', 'name' => 'test', 'image' => ''},
        :credentials => {
            :token => '1422989198008919',
            :expires_at => 1521747205,
            :expires => true
        },
        'type' => 'signin'
    })

    def log_in_user(user_id)
        session[:user_id] = user_id
    end

    def log_out_user(user_id)
        if session[:user_id] == user_id
            session[:user_id] = nil
        end
    end

    # Add more helper methods to be used by all tests here...
end
