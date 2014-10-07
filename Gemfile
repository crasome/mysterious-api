source 'https://rubygems.org'

gem 'rails', '4.1.5'
gem 'rails-api', '~> 0.2.1'

gem 'sqlite3'

gem 'pundit',       '~> 0.3.0'
gem 'active_type',  '~> 0.2.1'
gem 'versionist',   '~> 1.3.0'

gem 'raddocs', github: 'smartlogic/raddocs'
gem 'active_model_serializers', '~> 0.9.0', github: 'rails-api/active_model_serializers', branch: '0-9-stable'

group :test, :development do
  gem 'rspec-rails', '~> 3.0.0'
  gem 'rspec_api_documentation'
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'pry-nav'
end

group :test do
  gem 'coveralls', require: false

  gem 'turnip', github: "jnicklas/turnip"
  gem 'capybara', github: "jnicklas/capybara"
  gem 'webmock'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'capybara-angular'
end

group :development do
  gem 'spring'
end
