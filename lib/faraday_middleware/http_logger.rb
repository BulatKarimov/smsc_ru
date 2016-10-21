require 'faraday'

# namespace for faraday middleware
module FaradayMiddleware
  # Log all request to logger, filter login and password
  class HttpLogger < Faraday::Middleware
    extend Forwardable
    def_delegators :@logger, :debug, :info, :warn, :error, :fatal

    # Create middleware object
    #
    # params app [Faraday::Adapter::NetHttp] faraday adapter
    # params logger [Logger] middleware login
    #
    def initialize(app, logger)
      @app = app
      @logger = logger
    end

    # Log request to logger
    #
    # @param env [Faraday::Env] middleware environment
    #
    def call(env)
      start_time = Time.now
      info  { request_info(env) }
      debug { "Request headers: #{env[:request_headers].inspect}" }
      @app.call(env).on_complete do
        end_time = Time.now
        response_time = end_time - start_time
        info  { response_info(env, response_time) }
        debug { "Response headers: #{env[:response_headers].inspect}" }
        debug { "Response body: #{env[:body].delete("\n")}" }
      end
    end

    private

    def filter(output)
      output = output.to_s.gsub(/login=[a-zA-Z0-9_]*/, 'login=[LOGIN]')
      output.to_s.gsub(/psw=[a-zA-Z0-9_]*/, 'psw=[PASSWORD]')
    end

    def request_info(env)
      format('Started %s request to: %s', env[:method].to_s.upcase, filter(env[:url]))
    end

    def response_info(env, response_time)
      format('Response from %s; Status: %d; Time: %.1fms', filter(env[:url]), env[:status], (response_time * 1_000.0))
    end
  end
end
