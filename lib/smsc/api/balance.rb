require_relative '../models/balance'

module Smsc
  # namespace for api classes
  module Api
    # Balance api module
    module Balance
      # Receive customer balance
      #
      # @return [Smsc::Balance] balance model
      #
      # @example
      #  #receive balance
      #  client.balance
      #
      def balance
        request(
          endpoint: 'balance',
          params: {},
          model: Smsc::Balance,
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
