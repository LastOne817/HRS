class IdfsControllerTest < ActionController::TestCase

    test '#idf_createAll' do
        request.env["HTTP_REFERER"] = "/pages/main"
        post :createAll
        t = Idf.find_by(:prop => "collecting")
        assert t != nil
    end

    test '#idf_update' do
        request.env["HTTP_REFERER"] = "/pages/main"
        post :update
        t = Idf.find_by(:prop => "collecting")
        assert_in_delta t.value, 1.3862943, 0.000001 
    end

    test '#idf_update_not_contains' do
        request.env["HTTP_REFERER"] = "/pages/main"
        post :update
        t = Idf.find_by(:prop => "nonexsistence")
        assert t.value == 0
    end

    test '#idf_destroy' do
        request.env["HTTP_REFERER"] = "/pages/main"
        post :createAll
        post :destroy, {"prop" => "collecting"}
        t = Idf.find_by(:prop => "collecting")
        assert t == nil
    end
end
