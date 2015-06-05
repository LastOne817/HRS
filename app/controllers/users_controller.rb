require 'digest'
require 'active_support/all'
class UsersController < ApplicationController
    include UsersHelper

    def login
        @user = User.find_by(email: params[:email])
        if @user == nil
            flash[:alert] = "email doesn't exist"
            redirect_to :back	
        elsif @user.password == Digest::SHA256.hexdigest(@user.salt + params[:password])
            session[:user_id] = @user.id
            flash[:alert] = " Logged in Successfully"
            redirect_to root_path
        else
            flash[:alert] = "Incorrect email and password combination"
            redirect_to :back
        end
    end

    def signup

        @user = User.new(:email => params[:email])
        @user.username = params[:username]
        if params[:password].length < 5 || params[:password].length >20
            flash[:alert]="Password should be 5~20 characters"
            redirect_to :back
        elsif params[:password] == params[:password_confirmation]
            @user.salt = SecureRandom.base64(8)
            @user.password =  Digest::SHA256.hexdigest(@user.salt + params[:password])
            if @user.save
                @user.uid = @user.id
                @user.image = "http://cdn.ddanzi.com/201310-images/1531864.jpg"
                @user.save
                @like = Like.new
                @like.user_id = @user.id
                @like.save                
                
                flash[:alert] = "Signed in successfully"
                session[:user_id] = @user.id
                redirect_to root_path
            else

                if @user.errors[:email].length!=0
                    flash[:alert]="Email already exist"
                    #	elsif @user.errors[:password].length!=0
                    #	    flash[:alert]="Password should be 5~20 characters"
                end
                redirect_to :back
            end
        else
            flash[:alert]="Password Confirm is incorrect"
            redirect_to :back
        end
    end

    def logout
        flash[:alert] = "logged out successfully"
        session[:user_id] = nil
        redirect_to root_path
    end

    def changePhoto
        @user = User.find(session[:user_id])

        uploaded_io = params[:photo]
        if uploaded_io.original_filename.include?(".jpg") == false
            flash[:alert] = "Only jpg file can be uploaded"
            redirect_to :back
        else

            File.open(Rails.root.join('public', 'profile', @user.id.to_s), 'wb') do |file|
                file.write(uploaded_io.read)
            end

            @user.image = "/profile/" + @user.id.to_s
            @user.save
            flash[:alert]="Photo Changed Successfully"
            redirect_to root_path
        end
    end

    def changePassword
        @user = User.find(session[:user_id])

        if Digest::SHA256.hexdigest(@user.salt + params[:current_password]) == @user.password &&  params[:new_password] == params[:confirm_password]
            @user.password = Digest::SHA256.hexdigest(@user.salt + params[:new_password])
            @user.save
            flash[:alert]="Password has changed sucessfully"
            redirect_to root_path
        else
            flash[:alert]="Incorrect Input combination"
            redirect_to :back
        end

    end

    def deleteUser
        @user = User.find(params[:id])
        flash[:alert] = "your account is deleted successfully"
        session[:user_id] = nil
        @user.destroy
        redirect_to root_path
    end

end
