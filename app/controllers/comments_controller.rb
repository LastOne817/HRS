class CommentsController < ApplicationController

    def create
        @comment= Comment.new(:text => params[:text])
        @comment.article_id = params[:article_id]
        @comment.user_id = session[:user_id]
        if @comment.save
            flash[:alert] = "Comment is created successfully"
            redirect_to :back
        else
            flash[:alert] = "Incorrect Comment"
            redirect_to :back
        end
    end

    def delete
        @comment = Comment.find(params[:comment_id])
        if @comment.destroy
            flash[:alert]="Comment is deleted Successfully"
            redirect_to :back
        end
    end

end
