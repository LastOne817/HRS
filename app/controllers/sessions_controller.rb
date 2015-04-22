class SessionsController < ApplicationController
    def create
        user = User.omniauth(env['omniauth.auth'])
        sessoins[:user_id] = user.id
        redirect_to root_url
    end
    
    def destroy
        session[:user_id] = nil
    end
end
