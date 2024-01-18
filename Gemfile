source 'https://rubygems.org'
git_source(:github) { |repo| 'https://github.com/#{repo}.git' }

ruby "3.1.4"

# Payment processing
gem "pay", "~> 7.0"
gem "stripe", "~> 10.0"

# Install gem due to Faraday :json type issue
gem 'faraday_middleware'

# Environment variables
gem 'dotenv-rails'

# Lock i18n due to chewy compatibility issue
gem 'i18n', "~> 1.8.11"

# OpenAI API integration
gem 'ruby-openai'

# Template management
gem 'liquid'

# User authorisation
gem "devise", "~> 4.9"

# Background processing
gem "sidekiq", "~> 7.1"

# AWS services
gem 'aws-sdk-s3', '~> 1'
gem 'aws-sdk-rekognition', '~> 1'
gem 'aws-sdk-sqs', '~> 1'

# Rails
gem 'rails', '~> 7.0.5'
gem 'sprockets-rails'

# Database management
gem 'pg'

# Elasticsearch
gem 'chewy'

# CSS
gem "tailwindcss-rails", "~> 2.0"

gem 'puma', '~> 5.0'

# Hotwire features
gem 'importmap-rails'
gem 'turbo-rails'
gem 'stimulus-rails'

gem 'jbuilder'

gem 'redis', '~> 4.0'

gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]

gem 'bootsnap', require: false

group :development, :test do
  # Debugging
  gem 'byebug'
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
