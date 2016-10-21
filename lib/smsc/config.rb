module Smsc
  # Smsc configuration container.
  #
  # @attr login [String] user login
  # @attr password [String] user password
  # @attr host [String] api host
  # @attr ssl [Boolean] use https for requests
  # @attr logger [Logger] logger
  #
  class Config
    attr_accessor \
      :login,
      :password,
      :host,
      :ssl,
      :logger

    # Create configuration object
    #
    # @param params [Hash]
    # @option login [String] user login
    # @option password [String] user password
    # @option host [String] api host
    # @option ssl [Boolean] use https for requests
    # @option logger [Logger] logger instance
    #
    # @example
    #  Smsc::Config.new(
    #   login: 'a',
    #   password: 2
    #  )
    #
    def initialize(params = {})
      params.each do |key, val|
        send("#{key}=", val)
      end
    end
  end
end
