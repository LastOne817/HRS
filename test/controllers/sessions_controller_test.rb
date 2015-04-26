require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
    test '#signup_trial' do
        get :new
        assert_redirected_to '/auth/facebook?type=signin'
    end

    test '#login_trial' do
        get :find
        assert_redirected_to '/auth/facebook?type=login'
    end

    test '#logout' do
        get :destroy
        assert session[:user_id] == nil
        assert_redirected_to root_path
    end
end
