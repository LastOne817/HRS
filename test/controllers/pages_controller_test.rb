require 'test_helper'

class PagesControllerTest < ActionController::TestCase
   test '#get_indexpage' do
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

   test '#get_mainpage' do
     request.env["HTTP_REFERER"] = "/pages/main"
     session[:user_id] = 1
     get :main
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
        w = Weight.new
        w.weightList = [[{prop: "rich", weight: 1.0}],
                        [{prop: "team", weight: 0.333}, {prop: "online", weight: 0.5}],
                        [{prop: "solo", weight: 0.5}, {prop: "writing", weight: 0.333}],
                        [{prop: "ps", weight: 0.333}],
                        [{prop: "ps", weight: 0.333}, {prop: "observe", weight: 0.25}],
                        [{prop: "competitive", weight: 0.2}, {prop: "persistence", weight: 0.2}],
                        [{prop: "collecting", weight: 0.333}],
                        [{prop: "active", weight: 0.333}, {prop: "team", weight: 0.333}],
                        [{prop: "ps", weight: 0.333}, {prop: "persistence", weight: 0.2}],
                        [{prop: "gamble", weight: 0.333}, {prop: "competitive", weight: 0.2}],
                        [{prop: "mechanic", weight: 0.5}],
                        [{prop: "competitive", weight: 0.2}, {prop: "persistence", weight: 0.2}],
                        [{prop: "observe", weight: 0.25}, {prop: "persistence", weight: 0.2}],
                        [{prop: "competitive", weight: 0.2}, {prop: "team", weight: 0.333}],
                        [{prop: "handuse", weight: 0.333}],
                        [{prop: "collecting", weight: 0.333}],
                        [{prop: "competitive", weight: 0.2}],
                        [{prop: "active", weight: 0.333}, {prop: "art", weight: 0.25}],
                        [{prop: "art", weight: 0.25}, {prop: "writing", weight: 0.333}],
                        [{prop: "solo", weight: 0.5}, {prop: "online", weight: 0.5}],
                        [{prop: "offline", weight: 1.0}, {prop: "observe", weight: 0.25}],
                        [{prop: "art", weight: 0.25}, {prop: "persistence", weight: 0.2}],
                        [{prop: "mechanic", weight: 0.5}, {prop: "handuse", weight: 0.333}],
                        [{prop: "gamble", weight: 0.333}, {prop: "active", weight: 0.333}],
                        [{prop: "writing", weight: 0.333}, {prop: "art", weight: 0.25}],
                        [{prop: "collecting", weight: 0.333}, {prop: "handuse", weight: 0.333}],
                        [{prop: "gamble", weight: 0.333}, {prop: "observe", weight: 0.25}],
                        [{prop: "mechanic", weight: 0.5}]]
        w.save
        session[:user_id] = 1
        u = User.find(session[:user_id])
        u.checklist =  [{:prop=>"rich", :weight=>1.0}, {:prop=>"team", :weight=>0.666}, {:prop=>"online", :weight=>0.5}, {:prop=>"solo", :weight=>0.25}, {:prop=>"writing", :weight=>0.1665}, {:prop=>"ps", :weight=>0.333}, {:prop=>"observe", :weight=>0.625}, {:prop=>"competitive", :weight=>0.6000000000000001}, {:prop=>"persistence", :weight=>0.7000000000000001}, {:prop=>"collecting", :weight=>0.49950000000000006}, {:prop=>"active", :weight=>0.1665}, {:prop=>"gamble", :weight=>0.49950000000000006}, {:prop=>"mechanic", :weight=>1.25}, {:prop=>"handuse", :weight=>0.8325}, {:prop=>"art", :weight=>0.125}, {:prop=>"offline", :weight=>0.0}]
        u.save
        request.env["HTTP_REFERER"] = "/articles/1"
        post :setlike, {value: 0,hobby_id: 2}
        result = JSON.parse(response.body)
        assert result["error_code"]==0
        post :setlike, {value: 1,hobby_id: 4}
    end

    test '#test_setlike_failure' do
        request.env["HTTP_REFERER"] = "/articles/1"
        session[:user_id] = 1
        post :setlike, {value: 1,hobby_id: 1}
        result = JSON.parse(response.body)
        assert result["error_code"]==1
    end


end
