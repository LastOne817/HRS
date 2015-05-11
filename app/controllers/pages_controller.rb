class PagesController < ApplicationController

    before_filter :makeAlert

    def index
        flash[:alert] = flash.now[:alert]
        redirect_to  :action => 'main'
    end

    def main
    end

    def login
    end

    def signup
    end

    def checklist
    end

    def wiki
    end

    def result
    end

    def profile
        @user = User.find(session[:user_id])
    end

    private
    def makeAlert
        flash.now[:alert] = flash[:alert]
    end
end
