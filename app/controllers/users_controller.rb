class UsersController < ApplicationController
  # As of now show action is used for home page after user signs up/logs in
  before_action :redirect_logged_in, only: [:front, :new, :create]
  before_action :redirect_logged_out, only: [:show]
  
  def front
  end
  
  def select_plan
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
      redirect_to new_user_subscription_path(@user)
    else
      flash[:error] = "Invalid entry - check form below for details."
      render 'new'
    end
  end
  
  def show
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email, :password, :zip_code, :plan)
  end
end