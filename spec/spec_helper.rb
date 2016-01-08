require 'coveralls'
Coveralls.wear!

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'foodchain'
require 'webmock/rspec'

RSpec.configure do |config|
  config.order = 'random'
end
