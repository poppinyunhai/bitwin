source 'http://ruby.taobao.org'
# source 'http://rubygems.org'

gem 'rails', '4.0.0'
# 观察者
gem 'rails-observers'
# IP 地址查询
gem 'taobao_geoip'
# google
gem 'google-authenticator-rails'
gem 'coffee-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

gem 'sass'
gem 'sass-rails', '~> 4.0.0'
gem 'bootstrap-sass', '~> 2.3.2.1'

# Sass gem for stylesheets
gem 'compass', '~> 0.12.2'

# Better support for jquery in rails
gem 'jquery-rails'

gem 'mysql2'
gem 'slim', '~> 2.0.1'
gem 'cancan'
gem 'unicorn'

gem 'devise'
gem 'devise-async'
gem 'devise-encryptable'

gem 'settingslogic'
gem 'china_sms'

# gem cells
gem 'cells'

# resque and extends
gem 'resque'
gem 'resque_mailer'
gem 'resque-scheduler', :require => 'resque_scheduler'

# Form DSL for nicer form code in views
gem "simple_form", "~> 3.0.0.rc"
gem 'redis-rails' # Will install several other redis-* gems

gem 'carrierwave'
gem 'mime-types'
gem "mini_magick"

gem "mechanize", "~> 2.7.2"

group :development do
  gem 'capistrano'
  gem 'rvm-capistrano'
  # https://github.com/sosedoff/capistrano-unicorn/issues/28
  gem 'capistrano-unicorn', :require => false
  gem "better_errors"
end


group :test do
  gem 'turn', :require => false
  gem 'rspec-rails','~> 2.13.2'
  gem 'cucumber-rails', :require => false
  gem 'spork'
  gem 'spork-rails', github: 'railstutorial/spork-rails'
  gem 'database_cleaner', '~> 1.0.1'
  gem 'factory_girl_rails', :require => false
  gem "capybara" ,'~> 2.1.0'
  gem "launchy" ,'~> 2.3.0'
  gem 'guard-spork' ,'~> 1.5.1'
  gem 'guard-rspec' ,'~> 3.0.2'
  gem 'guard-livereload' ,'~> 1.4.0'
  gem 'guard-bundler' ,'~> 1.0.0'
  gem 'guard-cucumber' ,'~> 1.4.0'

  gem 'shoulda-matchers', "~> 2.2.0" #should be upgraded for rails 4

  gem "poltergeist", "~> 1.3.0"
  gem 'simplecov', :require => false
end
