class ArticlesController < ApplicationController

    def create
        if params[:q1]==nil || params[:q2]==nil || params[:q3]==nil || params[:q4]==nil
            flash[:alert] = "Please answer the all questions"
            redirect_to :back
        else
        
            @article = Article.new(hobby_first: params[:q1],hobby_second: params[:q2],hobby_third: params[:q3], hobby_fourth: params[:q4])
	    if @article.save
                redirect_to @article
            else
                redirect_to :back
            end
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
