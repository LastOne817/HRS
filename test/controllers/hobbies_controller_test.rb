require 'test_helper'

class HobbiesControllerTest < ActionController::TestCase

 test '#hobbies_open_new_hobby' do
        request.env["HTTP_REFERER"] = "/hobbies"
        get :new 
    end

 test '#hobbies_view_index_hobby' do
       get :index
    end

 test '#hobbies_show_hobby' do
       get :show, {id: 1}
    end
 
 test '#hobbies_edit_hobby' do
       get :edit, {id: 1}
    end

 test '#hobbies_destory_hobby' do
      h = Hobby.new
      h.name = "destroy"
      h.content = "destroy"
      h.save
      hh = h.id 
      get :destroy, {id: hh}
      h = Hobby.find_by(id: hh)
      assert h==nil
    end

 test '#hobbies_create_hobby_success' do
      
     t = {:name => "hobbies_create_hobby", :content => "testcontent"}
     post :create, {hobby: t}
     h = Hobby.find_by(name: "hobbies_create_hobby")
     assert h.content == "testcontent"
    end

 test '#hobbies_create_hobby_success_with_image' do
    file = File.new(Rails.root + 'app/assets/images/Penguins.jpg')
     upload = ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file))
     t = {:name => "hobbies_create_hobby_success", :content => "testcontent", :photo => upload}
     post :create, {hobby: t}
     h = Hobby.find_by(name: "hobbies_create_hobby_success")
     assert h.content == "testcontent"
     assert h.image == "/hobbyimage/" + h.id.to_s
    end

test '#hobbies_create_hobby_failure_with_image' do
     request.env["HTTP_REFERER"] = "/pages/main"
     file = File.new(Rails.root + 'app/assets/images/logo.png')
     upload = ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file))
     t = {:name => "hobbies_create_hobby_failure", :content => "testcontent", :photo => upload}
     post :create, {hobby: t}
     h = Hobby.find_by(name: "hobbies_create_hobby")
     assert h == nil
    end


 test '#hobbies_update_hobby_failure' do
     request.env["HTTP_REFERER"] = "/pages/main"
     file = File.new(Rails.root + 'app/assets/images/logo.png')
     upload = ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file))
     t = {:name => "hobbies_update_hobby_failure", :content => "testcontent"}
     post :create, {hobby: t}
     h = Hobby.find_by(name: "hobbies_update_hobby_failure")
     t = {:name => "hobbies_update_hobby_failure", :content => "contentchanged", :photo => upload}
     post :update, {hobby: t, id: h.id}
     hh = Hobby.find_by(name: "hobbies_update_hobby_failure")
     assert hh.content == "testcontent"
 end

 test '#hobbies_update_hobby_success' do
     file = File.new(Rails.root + 'app/assets/images/Penguins.jpg')
     upload = ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file))
     t = {:name => "hobbies_update_hobby", :content => "testcontent"}
     post :create, {hobby: t}
     h = Hobby.find_by(name: "hobbies_update_hobby")
     t = {:name => "hobbies_update_hobby", :content => "contentchanged", :photo => upload}
     post :update, {hobby: t, id: h.id}
     hh = Hobby.find_by(name: "hobbies_update_hobby")
     assert hh.content == "contentchanged"
     assert hh.image == "/hobbyimage/" + hh.id.to_s
    end

    test '#hobby_not_exist' do
        get :show, {:id => 99999}
        assert_redirected_to "/pages/main"
        assert flash[:alert] == "hobby is deleted or not exist"
    end

end
