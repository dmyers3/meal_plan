class ApplicationMailer < ActionMailer::Base
  layout 'mailer'
  
  def welcome(user)
    mail from: "<#{app_name} <#{app_email}>", to: user.email, subject: "Welcome to #{app_name}!"
  end
end
