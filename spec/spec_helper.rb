ENV['RAILS_ENV'] ||= 'test'

require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require 'rspec/rails'
require "codeclimate-test-reporter"

CodeClimate::TestReporter.start
Rails.backtrace_cleaner.remove_silencers!
