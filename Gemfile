source 'https://rubygems.org'

gem 'sinatra', '~> 2.0.0'
gem 'twitter', '~> 6.1.0'
gem 'facets'
gem 'rake'

unless ENV['RACK_ENV'] == "production"
  group :development, :test do
    gem 'dotenv'
    gem 'rspec', '~> 3.6.0'
    gem 'rack-test'
    gem 'multi_json'
    gem 'vcr', '~> 3.0.3'
    gem 'webmock'

    gem 'pry'
    # Formatter for rspec
    gem 'fivemat'
  end
end
