source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.3'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
#gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# This is a gem to helper you quick create a share feature in you Rails apps.
gem 'social-share-button'
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'
# semantic-ui-sass is an Sass-powered version of Semantic UI and ready to drop into Rails, Compass, or Sprockets.
gem 'semantic-ui-sass'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false 
# will_paginate is a pagination library that integrates with Ruby on Rails, Sinatra, Hanami::View, Merb, DataMapper and Sequel.
gem 'will_paginate', '~> 3.1.0'
# This gem integrates the Twitter Bootstrap pagination component with the will_paginate pagination gem.
gem 'will_paginate-bootstrap'
# Devise is a flexible authentication solution for Rails based on Warden.
gem 'devise'
# Strategy to authenticate with Google via OAuth2 in OmniAuth.
gem 'omniauth-google-oauth2'
# Shim to load environment variables from .env into ENV in development.
gem 'dotenv-rails', groups: [:development, :test, :production]
gem 'whenever', require: false
gem "letter_opener", :group => :development
# This gem provides jQuery and the jQuery-ujs driver for your Rails 4+ application.
gem 'jquery-rails', '~> 4.3', '>= 4.3.1'
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '~> 1.4'

end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'simplecov', :require => false
  gem "capybara"
end

group :production do
  gem 'pg'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
