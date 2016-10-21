$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'smsc'
require 'webmock/rspec'
require 'vcr'

require 'simplecov'
SimpleCov.start

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
end
