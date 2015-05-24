class IdfsControllerTest < ActionController::TestCase

    test '#idf_createAll' do
        request.env["HTTP_REFERER"] = "/pages/main"
        post :createAll
        @t = Idf.find_by(:prop => "samplesample")
        assert @t != nil
    end

    test '#idf_update' do
        request.env["HTTP_REFERER"] = "/pages/main"
        post :update
        @t = Idf.find_by(:prop => "sample")
        assert (@t.value - Math.log(2.5)).abs <= 0.01
    end


    test '#idf_destroy' do
        request.env["HTTP_REFERER"] = "/pages/main"
        post :createAll
        post :destroy, {"prop" => "sample"}
        @t = Idf.find_by(:prop => "sample")
        assert @t == nil
    end
end
