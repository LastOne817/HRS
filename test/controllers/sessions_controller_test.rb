require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
    setup do
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
    end

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

    test '#signup_success' do
        request.env['omniauth.params'] = {'type' => 'signin' }
        get :auth, 'provider' => 'facebook', 'type' => 'signin'
        assert session[:user_id] == User.last.id
    end

    test '#signup_failed_already' do
        request.env['omniauth.params'] = {'type' => 'signin' }
        request.env['HTTP_REFERER'] = '/pages/signup'
        get :auth, 'provider' => 'facebook', 'type' => 'signin'
        get :auth, 'provider' => 'facebook', 'type' => 'signin'
        assert_equal flash[:alert], 'Already registered'
        assert_redirected_to '/pages/signup'
    end

    test '#signup_duplicate_email' do
        request.env['omniauth.params'] = {'type' => 'signin' }
        request.env['HTTP_REFERER'] = '/pages/signup'
        get :auth, 'provider' => 'facebook', 'type' => 'signin'
        request.env['omniauth.auth'].uid = '543215432154321'
        get :auth, 'provider' => 'facebook', 'type' => 'signin'
        assert_equal flash[:alert], 'Failed to Signin'
        assert_redirected_to '/pages/signup'
    end

    test '#login_success' do
        request.env['omniauth.params'] = {'type' => 'signin' }
        get :auth, 'provider' => 'facebook', 'type' => 'signin'
        get :destroy
        request.env['omniauth.params'] = {'type' => 'login' }
        get :auth, 'provider' => 'facebook', 'type' => 'login'
        assert session[:user_id] == User.last.id
    end
    
    test '#login_failure' do
        request.env['omniauth.params'] = {'type' => 'login' }
        request.env['HTTP_REFERER'] = '/pages/login'
        get :auth, 'provider' => 'facebook', 'type' => 'login'
        assert_equal flash[:alert], 'Not registered'
        assert_redirected_to '/pages/login'
    end

    test '#auth_strange_url' do
        request.env['omniauth.params'] = {'type' => 'strange_url' }
        get :auth, 'provider' => 'facebook', 'type' => 'login'
        assert_redirected_to root_path
    end
end
