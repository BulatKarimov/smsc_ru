require 'json'

module Smsc
  # Response parse
  class Response
    class << self
      def parse(body, request_params)
        json = JSON.parse(body, symbolize_names: true)
        raise_client_errors(json, request_params[:errors] || {})

        request_params[:model].new(json)
      end

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
