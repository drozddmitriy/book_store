# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Auth
gem 'cancancan'
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'

# Assets
gem 'bootstrap-sass'
gem 'font-awesome-rails'
gem 'haml-rails'
gem 'jquery-rails', '~> 4.3', '>= 4.3.3'
gem 'jquery-ui-rails'
gem 'rails-ujs', '~> 0.1.0'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

# Core
gem 'bootsnap', '>= 1.1.0', require: false
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.3'

# Storage
gem 'carrierwave'
gem 'fog-core', '2.1.0'
gem 'fog-google'
gem 'google-cloud-storage', '~> 1.11', require: false
gem 'mini_magick', '~> 4.8'

# Tools
gem 'aasm'
gem 'activeadmin'
gem 'country_select'
gem 'draper'
gem 'figaro'
gem 'pagy'
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'simple_form'
gem 'wicked'

group :development, :test do
  gem 'bullet', '~> 6.0', '>= 6.0.2'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'fasterer'
  gem 'letter_opener'
  gem 'pry'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'simplecov'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'database_cleaner'
  gem 'ffaker'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'webdrivers', '~> 3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
