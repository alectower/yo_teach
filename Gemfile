ruby '2.1.1'

source 'https://rubygems.org'

gem 'bcrypt'
gem 'bootstrap-sass', '~> 2.3.2.0'
gem 'coffee-rails'
gem 'faker'
gem 'will_paginate', '~> 3.0'
gem 'jbuilder'
gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'jquery-ui-rails'
gem 'nokogiri'
gem 'pry'
gem 'rails'
gem 'sass-rails', '~> 4.0.2'
gem 'simple_form'
gem 'stripe'
gem 'tinymce-rails'
gem 'turbolinks'
gem 'uglifier'
gem 'unicorn'

group :development do
  gem 'brakeman'
  gem 'flamegraph'
  gem 'metric_fu'
  gem 'rack-mini-profiler'
  gem 'turbulence'
  gem 'spring'
end

group :development, :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'poltergeist'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'simplecov'
end

group :development, :test, :integration, :staging do
  gem 'pg'
end

group :integration, :staging do
  gem 'rails_12factor'
end

group :staging do
  gem 'newrelic_rpm'
end
