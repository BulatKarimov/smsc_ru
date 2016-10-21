require 'faraday'
require_relative '../../lib/faraday_middleware/http_logger'
require_relative '../../lib/faraday_middleware/raise_http_exception'

module Smsc
  # @private
  module Connection
    private

    def connection(url)
      Faraday.new(url: url) do |connection|
        connection.params['login'] = config.login
        connection.params['psw'] = config.password
        connection.params['fmt'] = 3

        connection.use FaradayMiddleware::RaiseHttpException
        connection.use FaradayMiddleware::HttpLogger, config.logger

        connection.adapter Faraday.default_adapter
      end
    end
  end
end
