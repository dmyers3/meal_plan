if Rails.env.development?

  # Settings for mailcatcher on dev enviroment
  Rails.application.config.action_mailer.tap do |action_mailer|
   action_mailer.default_url_options = { :host => "https://meal-plan-dmyers3.c9users.io" }

    action_mailer.delivery_method = :letter_opener
    action_mailer.perform_deliveries = true
    action_mailer.raise_delivery_errors = false
    action_mailer.perform_caching = false
  end
end

if Rails.env.production?
  # Define settings for production SMTP Server
  Rails.application.config.action_mailer.tap do |action_mailer|
    action_mailer.default_url_options = { :host => ENV['MAILER_URL'] }

    action_mailer.delivery_method = :smtp
    action_mailer.perform_deliveries = true
    action_mailer.raise_delivery_errors = true
    action_mailer.smtp_settings = {
    :address => 'smtp-relay.sendinblue.com',
    :port => 587,
    :domain => 'dmyers3-meal-plan.herokuapp.com',
    :user_name => 'daniel.p.myers@gmail.com',
    :password => ENV['SENDINBLUE_PASSWORD'],
    :authentication => 'login',
    :enable_starttls_auto => true
  }
  end
end

if Rails.env.staging?
  # Define settings for staging SMTP Server
  Rails.application.config.action_mailer.tap do |action_mailer|
    action_mailer.default_url_options = { :host => 'https://dmyers3-meal-plan-staging.herokuapp.com' }

    action_mailer.delivery_method = :smtp
    action_mailer.perform_deliveries = true
    action_mailer.raise_delivery_errors = true
    action_mailer.smtp_settings = {
    :address => 'smtp-relay.sendinblue.com',
    :port => 587,
    :domain => 'dmyers3-meal-plan-staging.herokuapp.com',
    :user_name => 'daniel.p.myers@gmail.com',
    :password => ENV['SENDINBLUE_PASSWORD'],
    :authentication => 'login',
    :enable_starttls_auto => true
  }
  end
end