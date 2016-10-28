require 'spec_helper'

RSpec.describe Smsc do
  it 'configuration' do
    Smsc.configure do |config|
      config.host = 'custom host'
    end

    expect(Smsc.config.host).to eq('custom host')
  end

  it 'default options should be specify' do
    [:host, :ssl, :logger, :encoding].each do |option|
      expect(Smsc.config.send(option)).not_to be_nil
    end
  end
end
