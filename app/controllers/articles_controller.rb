class ArticlesController < ApplicationController
    def create
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
        qMatch = [[{prop: "rich", weight: 1.0}],
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

        for i in 0..27
            qMatch[i].each do |item|
                calcItem = item
                calcItem[:weight] *= respond[i][:value]
                qPropVec.add( calcItem )
            end
        end

        hobbyList = []
        Hobby.all.each do |hobby|
            prod = 0.0
            hobby_abs = 0.0
            q_abs = 0.0
            qPropVec.vec.each do |keyhash|
                if hobby.tfs.find_by(prop: keyhash[:prop]) != nil
                    prod += hobby.tfs.find_by(prop: keyhash[:prop]).value * keyhash[:weight]
                    hobby_abs += hobby.tfs.find_by(prop: keyhash[:prop]).value * hobby.tfs.find_by(prop: keyhash[:prop]).value
                    q_abs += keyhash[:weight]
                end
            end
            hobbyList.push({hobby: hobby, similarity: ((prod * prod) / (hobby_abs * q_abs)).nan? ? 0 : (prod * prod) / (hobby_abs * q_abs)})
        end

        hobbyList.sort! { |b, a| a[:similarity] <=> b[:similarity] }

        @article = Article.new(hobby_first: hobbyList[0][:hobby].id,hobby_second: hobbyList[1][:hobby].id,
                               hobby_third: hobbyList[2][:hobby].id, hobby_fourth: hobbyList[3][:hobby].id,
                               similarity_first: hobbyList[0][:similarity], similarity_second: hobbyList[1][:similarity],
                               similarity_third: hobbyList[2][:similarity], similarity_fourth: hobbyList[3][:similarity])
        if @article.save
            redirect_to @article
        else
            redirect_to :back
        end
    end

    def show
        @article = Article.find(params[:id])
        @comments = Comment.where(:article_id => params[:id])
    end

    def board 
        @article = Article.last(20)
        # Get most recent 20 items from database
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
