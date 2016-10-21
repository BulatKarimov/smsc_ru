module Smsc
  # Balance model
  #
  # @attr balance [Float] account balance
  #
  class Balance
    include Virtus.model

    # @!attribute balance
    #   @return [Float] current balance
    attribute :balance, Float
  end
end
