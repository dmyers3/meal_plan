source 'https://rubygems.org'
ruby '2.3.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.2'
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass'
gem 'bootstrap_form'
gem 'haml-rails'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'uglifier', '>= 1.3.0'
gem 'pg'
gem 'sidekiq'
gem 'puma', '~> 3.7'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bundler'
gem 'sentry-raven'
gem 'bcrypt', '~> 3.1.7'
gem 'figaro'
gem 'foreman'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'


# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'pry'
  gem 'pry-nav'
  gem 'rspec-rails', '3.6.0'
  
end

group :test do
  gem 'rails-controller-testing'
  gem 'database_cleaner', '1.4.1'
  gem 'shoulda-matchers', '2.7.0'
  gem 'webmock'
  gem 'fabrication'
  gem 'faker'
  gem 'capybara', '~> 2.13'
  gem 'capybara-email'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'poltergeist'
  gem 'phantomjs', :require => 'phantomjs/poltergeist'
end

group :development do
  gem 'thin'
  gem "better_errors"
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem "letter_opener_web"
end

group :production do
  gem 'rails_12factor'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
