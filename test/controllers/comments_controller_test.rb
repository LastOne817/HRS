require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
    # test "the truth" do
    #   assert true
    # end

    test '#comment_create_success' do
        request.env["HTTP_REFERER"] = "/articles/1"
        session[:user_id] = 1
        post :create, {'text' => 'asdfasdfa', 'article_id' => 1}
        assert_redirected_to "/articles/1"
        assert flash[:alert] == "Comment is created successfully"
    end

    test '#comment_delete_success' do
        request.env["HTTP_REFERER"] = "/articles/1"
        session[:user_id] = 1
        post :delete, {'comment_id' => 1}
        assert_redirected_to "/articles/1"
        assert flash[:alert] == "Comment is deleted Successfully"
    end

    test '#comment_create_failure' do
        request.env["HTTP_REFERER"] = "/articles/1"
        session[:user_id] = 1
        post :create, {'text' => '', 'article_id' => 1}
        assert_redirected_to '/articles/1'
        assert flash[:alert] == "Incorrect Comment"
    end
end
