module Smsc
  # Balance model
  class Balance
    include Virtus.model

    # @!attribute balance
    #   @return [Float] current balance
    attribute :balance, Float
  end
end
