# encoding: UTF-8

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'expert'
Expert.environment.require_all

require 'rspec'
require 'commonjs-rhino'
require 'pry-nav'

RSpec.configure do |config|
end
