require 'coveralls'
Coveralls.wear!

ENV['TEST'] = 'true'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'foodchain'
require 'webmock/rspec'

RSpec.configure do |config|
  config.order = 'random'
end
