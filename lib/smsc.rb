require 'logger'
require 'virtus'
require_relative 'smsc/version'
require_relative 'smsc/config'
require_relative 'smsc/errors'
require_relative 'smsc/client'

# Namespace for smsc API client
module Smsc
  DEFAULT_HOST = 'smsc.ru'.freeze
  DEFAULT_SSL = true
  DEFAULT_LOGGER = Logger.new(STDOUT)

  class << self
    def config
      @config ||= Config.new(
        login: nil,
        password: nil,
        host: DEFAULT_HOST,
        ssl: DEFAULT_SSL,
        logger: DEFAULT_LOGGER
      )
    end

    def configure
      yield(config)
    end
  end
end
