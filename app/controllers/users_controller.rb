class UsersController < ApplicationController
   include UsersHelper

   def login
	@user = User.find_by(email: params[:email])
	if @user == nil
	    flash[:alert] = "email doesn't exist"
	    redirect_to :back	
	elsif @user.password == params[:password]   
	    session[:user_id] = @user.uid
	    flash[:alert] = " Logged in Successfully"
	    redirect_to root_path
	else
	    flash[:alert] = "Incorrect email and password combination"
	    redirect_to :back
	end
   end

   def signup
	@errorparam = 0
	if User.find_by(:email => params[:email]) != nil
	    flash[:alert] = "email already exist"
	    @errorparam = 1
	end

	@user = User.new(:email => params[:email])
	@user.username = params[:username]
	if params[:password] == params[:password_confirmation] && @errorparam == 0
	    @user.password = params[:password]
	    if @user.save
		@user.uid = @user.id
		@user.image = "http://cdn.ddanzi.com/201310-images/1531864.jpg"
		@user.save
		flash[:alert] = "Signed in successfully"
		session[:user_id] = @user.uid
            	redirect_to root_path
	    else
		flash[:alert] ="Username is invalid"
		redirect_to :back
	    end
	elsif @errorparam == 1
	    redirect_to :back
	else
	    flash[:alert]="Password Confirm is incorrect"
	    redirect_to :back
	end
   end

   def signup_facebook
   end

   def logout
	flash[:alert] = "logged out successfully"
	session[:user_id] = nil
	redirect_to root_path
   end

   def changePhoto
   end

   def changePassword
	@user = User.find_by(email: params[:email])

	if @user.authenticate(params[:password]) && params[:password] == params[:password_confirmation]
	    
	    #TODO check validate new password and change or print error message

	else
	    flash[:alert] = "Incorrect Password"
	end

   end

   def deleteUser
	@user = User.find_by(uid: params[:uid])
    	flash[:alert] = "your account is deleted successfully"
    	session[:user_id] = nil
    	@user.destroy
    	redirect_to root_path
   end
end
