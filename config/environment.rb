require 'simplecov'
SimpleCov.start 'rails' if ENV['RAILS_ENV']=='test' || ENV['RACK_ENV']=='test'

# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
