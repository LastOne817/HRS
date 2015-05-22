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
        questionList = ["Have enough money to spend on hobby",
        "Have experienced or enjoys on-line circle activity",
        "Like walking alone meditating",
        "Tend to make decision logically rather than emotionally",
        "Tend to wait rather than answer immediately even though you know something",
        "Have lots of experience of hurrying or running to get in line",
        "Have stronger temptation to buy something that you really don't need",
        "Quickly adapt in new situation",
        "Prefer to act immediately rather than speculate about various options",
        "Like drawing lots",
        "Curious about performance property of machines or tools",
        "Deadlines seem to be something of relative, rather than absolute, importance",
        "No surprises is better than surprises - bad or good ones",
        "Be fond of receiving compliments or recognition",
        "Enjoy controlling or operating something",
        "Tend to buy souvenirs when you go to trip",
        "Believe capitalism supports social evolution",
        "Always want to do new things",
        "Imagine worlds which are different from the world you live on from time to time",
        "Avoid revealing oneself to others",
        "Wish to meet other people and learn their lives",
        "Feels delight when you create something new",
        "Tend to fix on your own when you have something not working properly",
        "Want to go on an adventure if you can",
        "Often records own feelings, like diary",
        "Worn out things are also cool if you mend a bit",
        "Betting makes the game more interesting when you watch sports",
        "Believe progress of technology brings a more affluent life"]
        @questionaire = []
        for i in 1..questionList.length
            @questionaire.push({id: "q" + i.to_s, question: questionList[i-1]})
        end
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
