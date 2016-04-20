class SessionsController < ApplicationController
    def auth
        if(request.env['omniauth.params']['type'] == 'signin')
            if User.find_by(uid: request.env['omniauth.auth'].uid)
                flash[:alert] = "Already registered"
                redirect_to '/pages/signup'
            else
                user = User.omniauth(request.env['omniauth.auth'])
                if user.save
                    session[:user_id] = user.id
                    redirect_to root_url
                    like = Like.new
                    like.user_id = user.id
                    like.save
                else
                    flash[:alert]="Failed to Signin"
                    redirect_to '/pages/signup'
                end
            end
        elsif(request.env['omniauth.params']['type'] == 'login')
            if user = User.find_by(uid: request.env['omniauth.auth'].uid)
                session[:user_id] = user.id
                redirect_to root_url
            else
                flash[:alert] = "Not registered"
                redirect_to '/pages/login'
            end
        else
            redirect_to root_url
        end
    end

    def find 
        redirect_to '/auth/facebook?type=login'
    end

    def new
        redirect_to '/auth/facebook?type=signin'
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_url
    end
end
