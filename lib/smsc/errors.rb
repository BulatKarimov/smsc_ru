require 'faraday'

module Smsc
  # Custom error class for rescuing from all Smsc errors
  class Error < StandardError; end

  # Main class for client errors
  class ClientError < Error; end

  # Raised when Smsc return error with status code 1, 7
  class BadRequest < ClientError; end

  # Raised when Smsc return error with status code 2
  class Unauthorized < ClientError; end

  # Raised when Smsc return error with status code 4, 9
  class TooManyRequests < ClientError; end

  # Raised when Smsc return error with status code 3
  class PaymentRequired < ClientError; end

  # Raised when Smsc return error with status code 6
  class Forbidden < ClientError; end

  # Main class for server errors
  class ServerError < Error; end

  # Raised when Smsc returns the HTTP status code 500
  class InternalServerError < ServerError; end

  # Raised when Smsc returns the HTTP status code 502
  class BadGateway < ServerError; end

  # Raised when Smsc returns the HTTP status code 503
  class ServiceUnavailable < ServerError; end

  # Raised when Smsc returns the HTTP status code 504
  class GatewayTimeout < ServerError; end
end
