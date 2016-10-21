require 'faraday'
require 'json'

module FaradayMiddleware
  # @private
  class RaiseHttpException < Faraday::Middleware
    # Smsc always return 200, so we handle only network errors
    def call(env)
      @app.call(env).on_complete do |response|
        case response[:status].to_i
        when 500
          raise Smsc::InternalServerError, error_message_500(response, 'Something is wrong.')
        when 502
          raise Smsc::BadGateway, error_message_500(response, 'The server returned an invalid or incomplete response.')
        when 503
          raise Smsc::ServiceUnavailable, error_message_500(response, 'The server unavailable.')
        when 504
          raise Smsc::GatewayTimeout, error_message_500(response, 'Gateway Time-out')
        when 500..600
          raise Smsc::ServerError, error_message_500(response)
        end
      end
    end

    private

    def error_message_500(response, body = nil)
      "#{[response[:status].to_s + ':', body].compact.join(' ')} \
      #{response[:method].to_s.upcase} #{filter(response[:url].to_s)}"
    end

    def filter(url)
      url = url.to_s.gsub(/login=[a-zA-Z0-9_]*/, 'login=[LOGIN]')
      url.to_s.gsub(/psw=[a-zA-Z0-9_]*/, 'psw=[PASSWORD]')
    end
  end
end
