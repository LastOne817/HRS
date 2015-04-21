class ArticlesController < ApplicationController
    def new
        @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        if @article.save
            redirect_to @article
        else
            render 'new'
        end
    end

    def show
        @article = Article.find(params[:id])
    end

    def board 
        @article = Article.last(20)
        # Get most recent 20 items from database
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path
    end

    private
    def article_params
        params.require(:article).permit(:title, :text, :user)
        # Validating 
    end
end
