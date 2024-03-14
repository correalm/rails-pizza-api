source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.5'

gem 'mysql2', '~> 0.5'
gem 'rails', '~> 6.1.7', '>= 6.1.7.6'

gem 'puma', '~> 5.0'

gem 'bootsnap', '>= 1.4.4', require: false

gem 'blueprinter'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 6.1.0'
  gem 'shoulda-matchers', '~> 6.0'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end

group :test do
  gem 'json-schema'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
