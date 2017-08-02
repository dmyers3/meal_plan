class SubscriptionsController < ApplicationController
  before_action :redirect_logged_out
  before_action :redirect_incorrect_user
  
  def new
    @user = current_user
  end
  
  def create
    @user = current_user
    token = params[:stripeToken]
    customer = StripeWrapper::Customer.create( :email => "#{@user.email}", :source => token)
    if customer.successful?
      StripeWrapper::Subscription.create(
        customer: customer.response.id, plan: @user.plan)
      @user.update_attribute("customer_token", customer.customer_token)
      @user.update_attribute("paid_member", true)
      flash[:success] = "Subscription Started!"
      redirect_to home_path
    else
      flash[:error] = customer.error_message
      render 'new'
    end
  end
end