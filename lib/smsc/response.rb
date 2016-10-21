require 'json'

module Smsc
  # Response parse
  class Response
    class << self
      # Parse and wrap response in models, raise errors
      #
      # @param body [String] response body
      # @param parse_configuration [Hash] response parse configuration
      #
      # @raise [Smsc::ClientError] any of client errors
      #
      def parse(body, parse_configuration)
        json = JSON.parse(body, symbolize_names: true)
        raise_client_errors(json, parse_configuration[:errors] || {})

        parse_configuration[:model].new(json)
      end

      # Raise errors if response contain error code
      #
      # @private
      def raise_client_errors(json, error_map)
        error_code = json[:error_code]
        error_message = json[:error]
        return if error_code.nil?

        error_class = error_map[error_code.to_i]
        raise error_class, error_message unless error_class.nil?
        raise Smsc::ClientError, error_message
      end
    end
  end
end
