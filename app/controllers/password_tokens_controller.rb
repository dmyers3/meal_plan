class PasswordTokensController < ApplicationController
  before_action :redirect_logged_in, only: [:new, :create]
  
  def new
  end
  
  def create
    @user = User.find_by(email: params[:email])
    if @user
      @user.assign_token
      redirect_to confirm_reset_password_path
    else
      flash[:error] = "Could not find email address."
      render 'new'
    end
  end
end