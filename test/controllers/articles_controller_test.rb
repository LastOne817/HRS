require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase

  test '#article_create_success' do
      request.env["HTTP_REFERER"] = "/pages/checklist"
      post :create, {'first' => 1, 'second' => 2, 'third' => 3, 'fourth' => 1 }
      assert_redirected_to "/articles/1"
  end

  
end
