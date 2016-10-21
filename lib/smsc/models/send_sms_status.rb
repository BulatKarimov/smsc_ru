module Smsc
  # Status for send sms endpoint
  class SendSmsStatus
    include Virtus.model

    # @!attribute id
    #   @return [Integer] sms id
    attribute :id, Integer

    # @!attribute cnt
    #   @return [Integer] count transmitted sms
    attribute :cnt, Integer
  end
end
