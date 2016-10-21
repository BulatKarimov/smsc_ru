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
      # @return [Smsc::SendSmsStatus] response status
      #
      def send_sms(phones, message, options = {})
        params = options.merge(phones: phones, mes: message)

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
