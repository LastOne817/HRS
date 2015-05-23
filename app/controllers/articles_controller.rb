class ArticlesController < ApplicationController
    def create
        respond = []
        for i in 1..28
            qid = 'q' + i.to_s
            if !params.has_key?(qid)
                flash[:alert] = "Please answer the all questions"
                redirect_to :back and return
            end
            respond.push({id: qid, value: params[:qid]})
        end

        # TODO : Implement Algorithm

        @article = Article.new(hobby_first: params[:q1],hobby_second: params[:q2],hobby_third: params[:q3], hobby_fourth: params[:q4])
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
