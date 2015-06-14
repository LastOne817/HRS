class ArticlesController < ApplicationController
    def create

        if Hobby.count >= 4
            #it needs new indentation
            respond = []
            for i in 1..28
                qid = 'q' + i.to_s
                if !params.has_key?(qid)
                    flash[:alert] = "Please answer the all questions"
                    redirect_to :back and return
                end

                value = nil
                if params[qid] == "1"
                    value = 1
                elsif params[qid] == "2"
                    value = 0.5
                else
                    value = 0
                end
                respond.push({id: qid, value: value})
            end

            qPropVec = PropVec.new()
            qMatch = Weight.first.weightList

            for i in 0..27
                qMatch[i].each do |item|
                    calcItem = item
                    calcItem[:weight] *= respond[i][:value]
                    qPropVec.add( calcItem )
                end
            end

            hobbyList = []
            hobby_all = Hobby.all
            hobby_all.each do |hobby|
                prod = 0.0
                hobby_abs = 0.0
                q_abs = 0.0
                qPropVec.vec.each do |keyhash|
                    target_tf = hobby.tfs.find_by(prop: keyhash[:prop])
                    if taget_tf != nil
                        target_idf = Idf.find_by(prop: keyhash[:prop])
                        prod += target_tf.value * keyhash[:weight] * target_idf.value 
                        hobby_abs += ( target_tf.value * target_idf.value ) ** 2
                        q_abs += keyhash[:weight] ** 2
                    end
                end
                hobbyList.push({hobby: hobby, similarity: ((prod ** 2) / (hobby_abs * q_abs)).nan? ? 0 : (prod ** 2) / (hobby_abs * q_abs)})
            end

            hobbyList.sort! { |more, less| less[:similarity] <=> more[:similarity] }

            user = User.find(session[:user_id])
            user.checklist = qPropVec.vec
            user.save

            @article = Article.new(hobby_first: hobbyList[0][:hobby].id,hobby_second: hobbyList[1][:hobby].id,
                                   hobby_third: hobbyList[2][:hobby].id, hobby_fourth: hobbyList[3][:hobby].id,
                                   similarity_first: hobbyList[0][:similarity], similarity_second: hobbyList[1][:similarity],
                                   similarity_third: hobbyList[2][:similarity], similarity_fourth: hobbyList[3][:similarity])
            @article.save
        redirect_to @article
        else
            flash[:alert] = "There is not enough hobbies to recommend"
            redirect_to :back
        end
    end

    def show
        @article = Article.find_by(id: params[:id])
        if @article == nil
            flash[:alert] = "article is deleted or not exist"
            redirect_to pages_main_path
        else
            @comments = Comment.where(:article_id => params[:id])
        end
    end

    def board
        @articles = Article.last(20)
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to root_path
    end
end

class PropVec
    attr_accessor :vec
    def initialize()
        @vec = []
    end

    def add(item)
        @vec.each do |prop|
            if item[:prop] == prop[:prop]
                prop[:weight] += item[:weight]
                return
            end
        end
        @vec.push(item)
    end
end
