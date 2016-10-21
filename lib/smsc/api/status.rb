require_relative '../models/status'

module Smsc
  module Api
    # Status api module
    module Status
      # Check status
      #
      # @param phone [String] user phone
      # @param sms_id [Integer] sms id
      # @param options [Hash]
      # @return [Smsc::Status] status object
      #
      def status(phone, sms_id, options = {})
        params = options.merge(phone: phone, id: sms_id)

        request(
          endpoint: 'status',
          params: params,
          model: Smsc::Status,
          errors: {
            1 => BadRequest,
            2 => Unauthorized,
            4 => TooManyRequests,
            9 => TooManyRequests
          }
        )
      end
    end
  end
end
