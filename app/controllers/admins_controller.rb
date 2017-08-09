class AdminsController < ApplicationController
  before_action :redirect_logged_out
  before_action :redirect_non_admin
  
  def redirect_non_admin
    unless current_user.admin?
      flash[:error] = "You do not have access to this page."
      redirect_to root_path
    end
  end
end