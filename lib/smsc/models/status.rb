module Smsc
  # Balance model
  class Status
    include Virtus.model

    # @!attribute status
    #   @return [Numeric] status for sent sms
    attribute :status, Numeric

    # @!attribute last_date
    #   @return [DateTime] date for last changed status
    attribute :last_date, DateTime

    # @!attribute last_timestamp
    #   @return [Integer] timestamp for last changed status
    attribute :last_timestamp, Integer

    # @!attribute err
    #   @return [Integer] error code if sms not delivered
    attribute :err, Integer
  end
end
