class ApplicationController < ActionController::Base
  before_action :set_raven_context
  protect_from_forgery with: :exception
  
  helper_method :logged_in?, :current_user, :app_name
  
  def app_name
    "Pass The Cheddar"
  end
  
  def app_email
    "support@passthecheddar.com"
  end
  
  def current_user
    @current_user ||= session[:user_id] ? User.find(session[:user_id]) : nil
  end
  
  def logged_in?
    !!current_user
  end
  
  def redirect_logged_out
    if !logged_in?
      flash[:error] = "Access reserved for members only. Please sign in or register first."
      redirect_to root_path
    end
  end
  
  def redirect_logged_in
    redirect_to home_path if logged_in?
  end
  
  def redirect_incorrect_user
    if current_user.id != params[:user_id].to_i
      flash[:error] = "You do not have access to this page."
      redirect_to root_path
    end
  end
  
  private

  def set_raven_context
    Raven.user_context(id: session[:current_user_id]) # or anything else in session
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
