class SessionsController < ApplicationController
    def auth
        if(env['omniauth.params']['type'] == 'signin')
            if User.find_by(uid: env['omniauth.auth'].uid)
                flash[:alert] = "Already registered"
                redirect_to :back
            else
                user = User.omniauth(env['omniauth.auth'])
                session[:user_id] = user.uid
                redirect_to root_url
            end
        elsif(env['omniauth.params']['type'] == 'login')
            if User.find_by(uid: env['omniauth.auth'].uid)
                session[:user_id] = env['omniauth.auth'].uid
                redirect_to root_url
            else
                flash[:alert] = "Not registered"
                redirect_to :back
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
