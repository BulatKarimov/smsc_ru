module Smsc
  # Smsc configuration container.
  #
  class Config
    attr_accessor \
      :login,
      :password,
      :host,
      :ssl,
      :logger

    def initialize(params = {})
      params.each do |key, val|
        send("#{key}=", val)
      end
    end
  end
end
