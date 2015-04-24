class CommentsController < ApplicationController
    def new
        @comment= Comment.new
    end

    def create
        @comment= Comment.new(comment_params)
        if @comment.save
            redirect_to @comment
        else
            render 'new'
        end
    end

    def show
        @comment = Comment.find(params[:id])
    end

    def list 
        @comment = Comment.all
        # Get all items from database
    end

    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        redirect_to comments_path
    end

    private
    def comment_params
        params.require(:comment).permit(:text, :user, :article)
        # Validating 
    end
end
