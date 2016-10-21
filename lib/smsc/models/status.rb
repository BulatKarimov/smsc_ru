module Smsc
  # Status model
  #
  # @attr status [Numeric] numeric status for sended sms
  # @attr last_date [DateTime] date for last changed status
  # @attr last_timestamp [Integer] timestamp for last changed status
  # @attr err [Integer] error code if sms not delivered
  #
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
