source 'https://rubygems.org'
ruby '2.3.0'

gem 'rails', '4.2.5.2'
gem 'rails-api'
gem 'spring', group: :development
gem 'pg'
gem 'devise_token_auth'
gem 'omniauth'
gem 'rack-cors', require: 'rack/cors'
gem 'carrierwave'
gem 'rmagick'
gem 'fog'
gem 'foreman'
gem 'active_model_serializers'
gem 'machinist', '>= 2.0.0.beta2'
gem 'pundit'
gem 'redis', '3.3.0'
gem 'redis-namespace'
gem 'resque', '1.26.0', require: 'resque/server'
gem 'resque-scheduler'
gem 'puma'
gem 'platform-api'
gem 'has_scope'
gem 'exponent-server-sdk'
gem 'whenever', require: false

group :staging, :production do
  gem 'rails_stdout_logging'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'rspec-activemodel-mocks'
  gem 'shoulda-matchers'
  gem 'byebug'
  gem 'pry'
end

group :test do
  gem 'webmock'
end
