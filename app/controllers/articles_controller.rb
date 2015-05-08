class ArticlesController < ApplicationController
    def new
        @article = Article.new
    end

    def create
        @article = Article.new(hobby_first: params[:first],hobby_second: params[:second],hobby_third: params[:third], hobby_fourth: params[:fourth])
	if @article.save
            redirect_to @article
        else
            render 'new'
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
