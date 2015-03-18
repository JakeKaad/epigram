class SessionsController < ApplicationController

  def new
    # doesn't need anything because is not model-backed form
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      flash[:notice] = "Successfully logged in"
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash[:error] = "User name or password entered incorrectly."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Successfully logged out."
    redirect_to root_path
  end

end
