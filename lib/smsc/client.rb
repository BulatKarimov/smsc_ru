require_relative 'request'
require_relative 'connection'

require_relative 'api/balance'
require_relative 'api/send_sms'
require_relative 'api/status'

module Smsc
  # Client provides access to SMSC API.
  #
  class Client
    attr_accessor :config

    def initialize
      @config = Smsc.config.dup
      yield(config) if block_given?

      raise ArgumentError, 'login required' if config.login.nil?
      raise ArgumentError, 'password required' if config.password.nil?
    end

    include Connection
    include Request

    include Api::Balance
    include Api::Status
    include Api::SendSms
  end
end
