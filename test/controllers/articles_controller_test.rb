require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase

  test '#article_create_success' do
      request.env["HTTP_REFERER"] = "/pages/checklist"
      post :create, {'q1' => 1, 'q2' => 2, 'q3' => 3, 'q4' => 1 }
      assert_redirected_to "/articles/2"
  end

  test '#article_create_failure' do
      request.env["HTTP_REFERER"] = "/pages/checklist"
      post :create, {'q1' => 1, 'q2' => 2, 'q3' => 3 }
      assert_redirected_to "/pages/checklist"
      assert flash[:alert] == "Please answer the all questions"
  end


  test '#article_show' do
      session[:user_id]=nil
      get :show, {:id => 1}
      assert true
  end
end
