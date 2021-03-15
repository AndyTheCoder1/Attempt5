class UserAuthenticationController < ApplicationController
  # Uncomment this if you want to force users to sign in before any other actions
  skip_before_action(:force_user_sign_in, { :only => [:sign_up_form, :create, :sign_in_form, :create_cookie, :home] })

  
  def allusers
    @users = User.all
    render({ :template => "user_authentication/all.html.erb" })
  end

  def editing
  render({ :template => "user_authentication/edit_profile_total.html.erb" })
  end

  def profile
    
    the_id = params.fetch("path_id")

    @correct_user = User.where({ :id => the_id }).at(0)

    @matching_answers = Answer.where({ :owner => the_id })

    render({ :template => "user_authentication/profile.html.erb" })
  end
  
  def sign_in_form
    render({ :template => "user_authentication/sign_in.html.erb" })
  end

  def create_cookie
    user = User.where({ :email => params.fetch("query_email") }).first
    
    the_supplied_password = params.fetch("query_password")
    
    if user != nil
      are_they_legit = user.authenticate(the_supplied_password)
    
      if are_they_legit == false
        redirect_to("/user_sign_in", { :alert => "Incorrect password." })
      else
        session[:user_id] = user.id
      
        redirect_to("/answers", { :notice => "Signed in successfully." })
      end
    else
      redirect_to("/user_sign_in", { :alert => "No user with that email address." })
    end
  end

  def destroy_cookies
    reset_session

    redirect_to("/", { :notice => "Signed out successfully." })
  end

  def sign_up_form
    render({ :template => "user_authentication/sign_up.html.erb" })
  end

  def create_admin

    user = session.fetch(:user_id)

    correct_user = User.where({ :id => user }).at(0)
    
    correct_user.admin = true

    correct_user.save

    redirect_to("/edit_user_profile", { :notice => "You are now and admin" })
    
    
  end

  def forfit_admin

    user = session.fetch(:user_id)

    correct_user = User.where({ :id => user }).at(0)
    
    correct_user.admin = false

    correct_user.save

    redirect_to("/edit_user_profile", { :notice => "You are no longer an admin" })
    
    
  end


  def create
    @user = User.new
    @user.email = params.fetch("query_email")
    @user.password = params.fetch("query_password")
    @user.password_confirmation = params.fetch("query_password_confirmation")
    @user.username = params.fetch("query_username")
    @user.admin = params.fetch("query_admin", false)

    save_status = @user.save

    if save_status == true
      session[:user_id] = @user.id
   
      redirect_to("/answers", { :notice => "User account created successfully."})
    else
      redirect_to("/user_sign_up", { :alert => "User account failed to create successfully."})
    end
  end
    
  def edit_profile_form

    the_id = @current_user.id

    @matching_answers = Answer.where({ :owner => the_id })

    @user = User.where({ :id => the_id}).at(0)

    render({ :template => "user_authentication/edit_profile.html.erb" })
  end

  def update
    @user = @current_user
    @user.email = params.fetch("query_email")
    @user.password = params.fetch("query_password")
    @user.password_confirmation = params.fetch("query_password_confirmation")
    @user.username = params.fetch("query_username")
    @user.admin = params.fetch("query_admin", false)
    
    if @user.valid?
      @user.save

      redirect_to("/", { :notice => "User account updated successfully."})
    else
      render({ :template => "user_authentication/edit_profile_with_errors.html.erb" })
    end
  end

  def destroy
    @current_user.destroy
    reset_session
    
    redirect_to("/", { :notice => "User account cancelled" })
  end
 
end
