source 'https://rubygems.org'
source 'https://rails-assets.org'

gem 'rails',             '4.2.3'
gem 'pg'
gem 'sass-rails',        '~> 4.0'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'haml-rails'
gem 'bootstrap-sass'
gem 'bootswatch-rails'
gem 'font-awesome-sass'
gem 'devise'
gem 'therubyracer'
gem 'echowrap'
gem 'lastfm'
gem 'unicorn'
gem 'figaro'
gem 'peek'
gem 'peek-performance_bar'
gem 'peek-git'
gem 'peek-pg'

# causes issues with angularjs. For a fix see: https://shellycloud.com/blog/2013/10/how-to-integrate-angularjs-with-rails-4
#gem 'turbolinks'              

# react
gem 'react-rails'

# angular
gem 'ngannotate-rails'
gem 'rails-assets-angular', '= 1.3.0'
gem 'rails-assets-angular-messages'
gem 'rails-assets-angular-loading-bar'
gem 'rails-assets-angular-route'
gem 'rails-assets-angular-resource'
gem 'rails-assets-angular-ui-bootstrap-bower'
gem 'rails-assets-lodash', '~> 2.4'
gem 'rails-assets-angular-strap'
gem 'rails-assets-angular-motion'
gem 'rails-assets-bootstrap-additions' # css additions for angular-strap

group :production do
  gem 'rails_12factor'
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'capistrano',         '~> 3.2.1'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rvm',     '~> 0.1.1'
  gem 'capistrano-rails',   '~> 1.1.1'

  gem 'thin' # better dev server
end

group :development, :test do
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'growl'
  gem 'capybara', github: 'jnicklas/capybara'
  gem 'poltergeist'
  gem 'launchy'
  gem 'simplecov'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'quiet_assets'  # reduce rails log signal/noise (don't include asset requests)
  gem 'letter_opener' # preview emails directly in browser

  gem 'pry-byebug'
  gem 'pry-doc'

  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  #gem 'vcr'
  #gem 'webmock', '= 1.13.0' # vcr complains if higher version
end

