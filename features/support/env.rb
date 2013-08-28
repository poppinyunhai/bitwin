# -*- coding: utf-8 -*-
require 'rubygems'
require 'spork'
require 'simplecov'

Spork.prefork do
  require 'cucumber/rails'
  require 'capybara/rspec'
  require 'factory_girl_rails'
  require 'database_cleaner'

  Capybara.default_selector = :css

  require 'capybara/poltergeist'
  Capybara.javascript_driver = :poltergeist

  ActionController::Base.allow_rescue = false

  begin
	  DatabaseCleaner.strategy = :transaction
  rescue NameError
    raise 'You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it.'
  end
  Cucumber::Rails::Database.javascript_strategy = :truncation

  World(FactoryGirl::Syntax::Methods)
end

Spork.each_run do
  FactoryGirl.reload
  SimpleCov.start
end

