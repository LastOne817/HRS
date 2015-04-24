class UsersController < ApplicationController
   include UsersHelper

   def login

	@user = User.find_by(email: params[:email])
	
	if @user && @user.authenticate(params[:password])
	    #TODO login success   
	    cookies[:user_id] = @user.id
	    redirect_to root_path
	else
	    #TODO error
	    flash[:alert] = "Incorrect email or password"	    
	end
   end

   def signup
	# TODO Uniqueness
	@user = User.new
	@user.email = params[:username]
	@user.nickname = params[:nickname]
	if params[:password] == params[:password_confirmation]
	    @user.password = params[:password]
	    if @user.save
		#TODO redirect to login and print message
	    else
		#TODO check error number and render json
	    end
	end
	
   end

   def logout
	flash[:alert] = "logged out successfully"
	cookies.delete(:user_id)
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
	@user = User.find_by(email: params[:email])
	@user.destroy
	flash[:alert] = "your account is deleted successfully"
	cookies.delete(:user_id)
	redirect_to root_path
   end
end
