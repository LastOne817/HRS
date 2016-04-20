require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  # signup
   test '#signup_success' do
     request.env["HTTP_REFERER"] = "/pages/signup"
     post :signup, {'email' => 'testuser@test.com', 'username' => 'testuser', 'password' => 'testpass', 'password_confirmation'=> 'testpass'}
     assert_redirected_to root_path
     assert flash[:alert] == "Signed in successfully"
   end

   test '#signup_password_confirm_failed' do
     request.env["HTTP_REFERER"] = "/pages/signup"
     post :signup, {'email' => 'testuser@test.com', 'username' => 'testuser', 'password' => 'testpass', 'password_confirmation'=> 'failure'}
     assert_redirected_to pages_signup_path
     assert flash[:alert] == "Password Confirm is incorrect"
   end

   test '#signup_password_invalid' do
     request.env["HTTP_REFERER"] = "/pages/signup"
     post :signup, {'email' => 'testuser@test.com', 'username' => 'testuser', 'password' => 'a', 'password_confirmation'=> 'a'}
     assert_redirected_to pages_signup_path
     assert flash[:alert] == "Password should be 5~20 characters"
   end
  
   test '#signup_email_exist' do
     request.env["HTTP_REFERER"] = "/pages/signup"
     post :signup, {'email' => 'already@signed.in', 'username' => 'testuser', 'password' => 'asdfasdf', 'password_confirmation'=> 'asdfasdf'}
     assert_redirected_to pages_signup_path
     assert flash[:alert] == "Email already exist"
   end

  #login

   test '#login_success' do
     request.env["HTTP_REFERER"] = "/pages/login"
     post :login, {'email' => 'already@signed.in', 'password' => 'asdfasdf'}
     assert_redirected_to root_path
     assert flash[:alert] == " Logged in Successfully"
   end

   test '#login_email_does_not_exist' do
     request.env["HTTP_REFERER"] = "/pages/login"
     post :login, {'email' => 'already@signed.out', 'password' => 'asdfasdf'}
     assert_redirected_to pages_login_path
     assert flash[:alert] == "email doesn't exist"
   end

   test '#login_password_failure' do
     request.env["HTTP_REFERER"] = "/pages/login"
     post :login, {'email' => 'already@signed.in', 'password' => 'failure'}
     assert_redirected_to pages_login_path
     assert flash[:alert] == "Incorrect email and password combination"
   end

  #logout

  test '#logout' do
     get :logout
     assert_redirected_to root_path
  end

  #deleteUser

  test '#deleteUser' do
     request.env["HTTP_REFERER"] = "/pages/profile"
     get :deleteUser, {'id' => '1'}
     assert_redirected_to root_path
     assert flash[:alert] == "your account is deleted successfully"
  end

  #changePassword

  test '#changePassword_success' do
     request.env["HTTP_REFERER"] = "/pages/profile"
     session[:user_id] = 1
     post :changePassword, {'current_password' => 'asdfasdf', 'new_password' => 'fdsafdsa', 'confirm_password' => 'fdsafdsa' }
     assert_redirected_to root_path
     assert flash[:alert] == "Password has changed sucessfully"
  end

  test '#changePassword_failure' do
     request.env["HTTP_REFERER"] = "/pages/profile"
     session[:user_id] = 1
     post :changePassword, {'current_password' => 'asdfasdf', 'new_password' => 'fdsafdsa', 'confirm_password' => 'asdfasdf' }
     assert_redirected_to pages_profile_path
     assert flash[:alert] == "Incorrect Input combination"
  end

  #changePhoto
  test '#changePhoto_success' do
     request.env["HTTP_REFERER"] = "/pages/profile"
     session[:user_id] = 1
   #  file = File.read(Rails.root.join('app', 'assets', 'images', 'logo.png'))
   
     file = File.new(Rails.root + 'app/assets/images/Penguins.jpg')
     upload = ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file))
     post :changePhoto, {'photo' => upload}
     assert_redirected_to root_path
     assert flash[:alert] == "Photo Changed Successfully"
  end

  test '#changePhoto_failure' do
     request.env["HTTP_REFERER"] = "/pages/profile"
     session[:user_id] = 1
   #  file = File.read(Rails.root.join('app', 'assets', 'images', 'logo.png'))

     file = File.new(Rails.root + 'app/assets/images/logo.png')
     upload = ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file))
     post :changePhoto, {'photo' => upload}
     assert_redirected_to pages_profile_path
     assert flash[:alert] == "Only jpg file can be uploaded"
  end



end
