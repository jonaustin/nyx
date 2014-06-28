source 'https://rubygems.org'
source 'https://rails-assets.org'
ruby '2.1.1'

gem 'rails',             '4.1.1'
gem 'pg',                '~> 0.17'
gem 'sass-rails',        '~> 4.0'
gem 'uglifier',          '>= 2.5'
gem 'coffee-rails',      '~> 4.0'
gem 'jquery-rails',      '~> 3.1'
gem 'haml-rails',        '~> 0.5'
gem 'bootstrap-sass',    '~> 3.1'
gem 'font-awesome-sass', '~> 4.1'
gem 'draper',            '~> 1.3'
gem 'devise',            '~> 3.2'
gem 'therubyracer',      '~> 0.12', platforms: :ruby
gem 'echowrap',          '0.1.3'
gem 'rockstar',          github: 'jonaustin/rockstar'
gem 'unicorn'
gem 'figaro'

# causes issues with angularjs. For a fix see: https://shellycloud.com/blog/2013/10/how-to-integrate-angularjs-with-rails-4
#gem 'turbolinks'              

gem 'ngmin-rails',                         '~> 0.4.0'
gem 'rails-assets-lodash',                 '~> 2.4.1'
#gem 'rails-assets-angular-local-storage',  '~> 0.0.4'
gem 'angular_rails_csrf',                  '~> 1.0'
gem 'rails-assets-angular-loading-bar'
gem 'rails-assets-angular-resource'

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

