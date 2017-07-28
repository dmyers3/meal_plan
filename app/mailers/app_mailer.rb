class AppMailer < ActionMailer::Base
  layout 'mailer'
  add_template_helper(ApplicationHelper)
  
  def welcome(user_id)
    user = User.find(user_id)
    mail from: "Pass The Cheddar <support@passthecheddar.com>", to: user.email, subject: "Welcome to Pass The Cheddar!"
  end
  
  def send_reset_password(user_id)
    @user = User.find(user_id)
    @token = @user.token
    mail from: "Pass The Cheddar <support@passthecheddar.com>", to: @user.email, subject: "Reset Password Link"
  end
end
