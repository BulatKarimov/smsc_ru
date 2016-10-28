require 'logger'
require 'virtus'
require_relative 'smsc/version'
require_relative 'smsc/config'
require_relative 'smsc/errors'
require_relative 'smsc/client'

# Namespace for smsc API client
module Smsc
  # Smsc api default host
  DEFAULT_HOST = 'smsc.ru'.freeze
  # Use https for api
  DEFAULT_SSL = true
  # Default logger for gem
  DEFAULT_LOGGER = Logger.new(STDOUT)
  # Encoding
  DEFAULT_ENCODING = 'utf-8'.freeze

  class << self
    # Create default configuration
    #
    def config
      @config ||= Config.new(
        login: nil,
        password: nil,
        host: DEFAULT_HOST,
        ssl: DEFAULT_SSL,
        encoding: DEFAULT_ENCODING,
        logger: DEFAULT_LOGGER
      )
    end

    # Method for external configuration
    #
    def configure
      yield(config)
    end
  end
end
