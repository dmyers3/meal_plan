class AppMailer < ActionMailer::Base
  layout 'mailer'
  add_template_helper(ApplicationHelper)
  
  def welcome(user)
    mail from: "Pass The Cheddar <support@passthecheddar.com>", to: user.email, subject: "Welcome to Pass The Cheddar!"
  end
end
