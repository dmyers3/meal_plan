class SessionsController < ApplicationController
  before_action :redirect_logged_in, only: [:new, :create]
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:email])
    
    if user.nil?
      flash[:error] = "Unable to find email address."
      render 'new'
    elsif user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path
    else
      flash[:error] = "Invalid Password."
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end