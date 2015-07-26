source 'https://rubygems.org'
ruby '2.2.1'

gem 'rails', '4.1.5'

gem 'versionist',   '~> 1.3.0'
gem 'date_validator', '~> 0.7.1'

gem 'raddocs', github: 'smartlogic/raddocs'
gem 'active_model_serializers',  '~> 0.9.0',  path: 'vendor/gems/active_model_serializers-0-9-stable'

gem 'slim-rails'
gem 'coffee-rails'
gem 'sass-rails'
gem 'bootstrap-sass', '~> 3.1.1'

gem 'virtus'

group :test, :development do
  gem 'rspec-rails', '~> 3.3'
  gem 'rspec_api_documentation', '~> 4.4.0'
  gem 'factory_girl_rails'
  gem 'pry-nav'
end

group :test do
  gem 'coveralls', require: false

  gem 'turnip'
  gem 'capybara'
  gem 'webmock'
  gem 'launchy'
  gem 'selenium-webdriver', '~> 2.46.2'
  gem 'capybara-angular'

  gem 'vcr'
end

group :development do
  gem 'spring'
end
