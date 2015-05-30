require 'test_helper'

class PagesControllerTest < ActionController::TestCase
   test '#get_mainpage' do
     #request.env["HTTP_REFERER"] = "/pages/index"
     get :index 
     assert_redirected_to pages_main_path
   end

   test '#get_checklistpage' do
     get :checklist
     assert true 
   end

   test '#get_profilepage' do
     request.env["HTTP_REFERER"] = "/pages/main"
     session[:user_id] = 1
     get :profile
     assert true
   end

    test '#get_showlikedpage' do
     request.env["HTTP_REFERER"] = "/pages/main"
     session[:user_id] = 1
     get :showliked
     assert true
   end
   
   test '#get_showdislikedpage' do
     request.env["HTTP_REFERER"] = "/pages/main"
     session[:user_id] = 1
     get :showdisliked
     assert true
   end

   test '#test_deletefromlist' do
     request.env["HTTP_REFERER"] = "/pages/showliked"
     session[:user_id] = 1
     get :deletefromlist, {id: 1}
     assert flash[:alert] == "Hobby is deleted from the list successfully"
   end

   test '#test_setlike_success' do
     request.env["HTTP_REFERER"] = "/articles/1"
     session[:user_id] = 1
     post :setlike, {value: 1,hobby_id: 2}
     result = JSON.parse(response.body)
     assert result["error_code"]==0
   end

   test '#test_setlike_failure' do
     request.env["HTTP_REFERER"] = "/articles/1"
     session[:user_id] = 1
     post :setlike, {value: 1,hobby_id: 1}
     result = JSON.parse(response.body)
     assert result["error_code"]==1
   end


end
