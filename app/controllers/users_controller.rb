class UsersController < ApplicationController
   include UsersHelper

   def login
	@user = User.find_by(email: params[:email])
	
	#if @user && @user.password == params[:password]
	if @user != nil   
	    session[:user_id] = @user.uid
	    redirect_to root_path
	else
	    flash[:alert] = "Incorrect email or password"
	    redirect_to :back
	end
   end

   def signup
	@user = User.new(:email => params[:email])
	@user.username = params[:nickname]
	if params[:password] == params[:password_confirmation]
	   # @user.password = params[:password]
	    if @user.save
		session[:user_id] = @user.uid
            	redirect_to root_path
	    else
		flash[:alert] ="Username is invalid"
		redirect_to :back
	    end
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
    #if @user.password == params[:confirm_password]
    flash[:alert] = "your account is deleted successfully"
    puts session[:user_id]
    session[:user_id] = nil
    @user.destroy
    puts session[:user_id]
    redirect_to root_path
   end
end
