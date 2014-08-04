# encoding: UTF-8

require 'jbundler'
require 'rspec'
require 'commonjs-rhino'
require 'pry-nav'

RSpec.configure do |config|
  config.mock_with :rr
end
