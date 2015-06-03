require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase

    test '#article_create_success' do
        request.env["HTTP_REFERER"] = "/pages/checklist"
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
        Hobby.destroy_all
        post :create, {'q1' => 1, 'q2' => 2, 'q3' => 3, 'q4' => 1, 'q5' => 1, 'q6' => 2, 'q7' => 3, 'q8' => 1, 'q9' => 1, 'q10' => 2, 'q11' => 3, 'q12' => 1,
                       'q13' => 1, 'q14' => 2, 'q15' => 3, 'q16' => 1, 'q17' => 1, 'q18' => 2, 'q19' => 3, 'q20' => 1, 'q21' => 1, 'q22' => 2, 'q23' => 3, 'q24' => 1,
                       'q25' => 1, 'q26' => 2, 'q27' => 3, 'q28' => 1 }
        assert_redirected_to "/pages/checklist"

        h1 = Hobby.new
        h1.name = "Hobby1"
        h1.save
        h2 = Hobby.new
        h2.name = "Hobby2"
        h2.save
        h3 = Hobby.new
        h3.name = "Hobby3"
        h3.save
        h4 = Hobby.new
        h4.name = "Hobby4"
        h4.save

        Tf.createAll(h1.id)
        Tf.createAll(h2.id)
        Tf.createAll(h3.id)
        Tf.createAll(h4.id)


        tf1 = h1.tfs
        tf2 = h2.tfs
        tf3 = h3.tfs
        tf4 = h4.tfs

        tf1.each do |tf|
            tf.value = 2.0
            tf.save
        end

        tf2.each do |tf|
            tf.value = 3.0
            tf.save
        end

        tf3.each do |tf|
            tf.value = 1.5
            tf.save
        end

        tf4.each do |tf|
            tf.value = 0.9
            tf.save
        end

        tf = Tf.find(h2.tfs.find_by(prop: "collecting").id)
        tf.value = 1.2
        tf.save

        tf = Tf.find(h3.tfs.find_by(prop: "collecting").id)
        tf.value = 3.7
        tf.save

        tf = Tf.find(h4.tfs.find_by(prop: "collecting").id)
        tf.value = 1.8
        tf.save

        post :create, {'q1' => 1, 'q2' => 2, 'q3' => 3, 'q4' => 1, 'q5' => 1, 'q6' => 2, 'q7' => 3, 'q8' => 1, 'q9' => 1, 'q10' => 2, 'q11' => 3, 'q12' => 1,
                       'q13' => 1, 'q14' => 2, 'q15' => 3, 'q16' => 1, 'q17' => 1, 'q18' => 2, 'q19' => 3, 'q20' => 1, 'q21' => 1, 'q22' => 2, 'q23' => 3, 'q24' => 1,
                       'q25' => 1, 'q26' => 2, 'q27' => 3, 'q28' => 1 }
        assert_redirected_to "/articles/2"
    end

    test '#article_destroy' do
        delete :destroy, {:id => 1}
        assert_redirected_to root_path
    end

    test '#article_create_failure' do
        request.env["HTTP_REFERER"] = "/pages/checklist"
        post :create, {'q1' => 1, 'q2' => 2, 'q3' => 3 }
        assert_redirected_to "/pages/checklist"
        assert flash[:alert] == "Please answer the all questions"
    end


    test '#article_show' do
        session[:user_id]=nil
        h1 = Hobby.new
        h1.name = "Hobby4"
        h1.content ="hobby4"
        h1.save
        h2 = Hobby.new
        h2.name = "Hobby5"
        h2.content = "hobby5"
        h2.save
        h3 = Hobby.new
        h3.name = "Hobby6"
        h3.content = "hobby6"
        h3.save
        h4 = Hobby.new
        h4.name = "Hobby7"
        h4.content = "hobby7"
        h4.save

        Tf.createAll(h1.id)
        Tf.createAll(h2.id)
        Tf.createAll(h3.id)
        Tf.createAll(h4.id)

        h = Article.new
        h.hobby_first=h1.id
        h.hobby_second=h2.id
        h.hobby_third=h3.id
        h.hobby_fourth=h4.id
        h.similarity_first = 0.9
        h.similarity_second = 0.7
        h.similarity_third = 0.5
        h.similarity_fourth = 0.3


        h.save

        get :show, {:id => h.id}

        assert true
    end

end
