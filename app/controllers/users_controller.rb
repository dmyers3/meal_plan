class UsersController < ApplicationController
  def front
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      AppMailer.delay.welcome(@user.id)
      flash[:success] = "Welcome to #{app_name}!"
      redirect_to home_path
    else
      flash[:error] = "Invalid entry - check form below for details."
      render 'new'
    end
  end
  
  def show
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email, :password, :zip_code)
  end
end