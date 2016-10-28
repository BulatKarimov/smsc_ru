require_relative '../models/send_sms_status'

module Smsc
  module Api
    # Send sms api module
    module SendSms
      # Check status
      #
      # @param phones [String] user phone
      # @param message [String] sms message
      # @param options [Hash]
      #
      # @return [Smsc::SendSmsStatus] response status
      #
      # @example
      #  #send one sms
      #  client.send_sms("79999999999", "Password: 123")
      #  #send multiple sms
      #  client.send_sms("79999999999,78888888888", "Password: 123")
      #  # add additional parameters
      #  client.send_sms("79999999999,78888888888", "Password: 123", translit: 1)
      #
      def send_sms(phones, message, options = {})
        params = {
          charset: config.encoding
        }.merge(options).merge(phones: phones, mes: message)

        request(
          endpoint: 'send',
          params: params,
          model: Smsc::SendSmsStatus,
          errors: {
            1 => BadRequest,
            2 => Unauthorized,
            3 => PaymentRequired,
            4 => TooManyRequests,
            5 => BadRequest,
            6 => Forbidden,
            7 => BadRequest,
            9 => TooManyRequests
          }
        )
      end
    end
  end
end
