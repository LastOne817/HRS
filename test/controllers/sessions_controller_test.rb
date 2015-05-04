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
    """test '#signup_success' do
        get :new
        get :auth, 'provider' => 'facebook', 'code' => 'AQALhVnkojZxDKB42KQf0qww0K3gSmeXt_I90BUcVrEfk9TfO2ROBVr-mKEJNo9EZmpYZHIX1jsGCsGBmndx2kpgTo8bF-rzI_Znth9vyoZYq-qPk-ZRBNH8JboqvP20NFlk6AdsXy-69uH1_1OFrLxTmvojYjLismnQORcOifjJDrQx1qDij0F64oltcUbei5tt-dnrZa9o3TipcgSqLvldm8NZwNJiqk6NzfDrgwuph_qDfKfhl31dkzUtS8YlhMhFGJ2pDiwiLVJzY2JUdcQ_RKqgzF4pKQNm3Ppo0U4yIlbi0htq-SRThLSn8TCokEbInfi7Bn2wCmevGwuUSrGY', 'state' => 'b2c7d0c8a6dd47d347f84f4b42ab5f953e010f84863ced96'
    end"""
end
