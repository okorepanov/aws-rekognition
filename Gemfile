source 'https://rubygems.org'
git_source(:github) { |repo| 'https://github.com/#{repo}.git' }

ruby "3.1.4"

gem 'dotenv-rails'
gem 'byebug'
gem 'ruby-openai'
gem 'liquid'
gem "devise", "~> 4.9"
gem "sidekiq", "~> 7.1"

gem 'aws-sdk-s3', '~> 1'
gem 'aws-sdk-rekognition', '~> 1'
gem 'aws-sdk-sqs', '~> 1'

gem 'rails', '~> 7.0.5'
gem 'sprockets-rails'

# gem 'mysql2', '~> 0.5'
gem 'pg'

gem 'puma', '~> 5.0'

gem 'importmap-rails'
gem 'turbo-rails'
gem 'stimulus-rails'

gem 'jbuilder'

gem 'redis', '~> 4.0'

gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ]

gem 'bootsnap', require: false

group :development, :test do
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
