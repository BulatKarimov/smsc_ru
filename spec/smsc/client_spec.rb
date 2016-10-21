require 'spec_helper'
require 'smsc/client'
require 'smsc/errors'
require 'logger'

RSpec.describe Smsc::Client do
  let(:subject) { Smsc::Client.new }

  before do
    Smsc.configure do |config|
      config.login = 'test_login'
      config.password = 'test_password'
      config.logger = Logger.new('/dev/null')
    end
  end

  describe 'override default configuration for clients' do
    it 'independent configuration' do
      client1 = Smsc::Client.new do |client|
        client.host = 'host_1'
      end

      client2 = Smsc::Client.new do |client|
        client.host = 'host_2'
      end

      expect(client1.config.host).to eq('host_1')
      expect(client2.config.host).to eq('host_2')
    end

    it 'defaults' do
      client = Smsc::Client.new

      expect(client.config.host).to eq(Smsc::DEFAULT_HOST)
    end
  end

  context 'balance' do
    it 'response' do
      VCR.use_cassette('balance') do
        response = subject.balance

        expect(response).to be_a(Smsc::Balance)
        expect(response.balance).to eq(1871.62)
      end
    end
  end

  context 'send_sms' do
    it 'response' do
      VCR.use_cassette('send_sms') do
        response = subject.send_sms('79998887766', 'test message')

        expect(response).to be_a(Smsc::SendSmsStatus)
        expect(response.id).to eq(33)
        expect(response.cnt).to eq(1)
      end
    end
  end

  context 'status' do
    it 'response' do
      VCR.use_cassette('status') do
        response = subject.status('79998887766', 30)

        expect(response).to be_a(Smsc::Status)
        expect(response.status).to eq(1)
        expect(response.err).to be_nil
      end
    end
  end

  context 'errors' do
    context 'client' do
      it 'unauthorised' do
        VCR.use_cassette('unauthorised') do
          expect do
            subject.balance
          end.to raise_error(Smsc::Unauthorized) { |error|
            expect(error.message).to eq('authorise error')
          }
        end
      end

      it 'bad request' do
        VCR.use_cassette('invalid_params') do
          expect do
            subject.send_sms('123', 'test_message')
          end.to raise_error(Smsc::BadRequest) { |error|
            expect(error.message).to eq('invalid number')
          }
        end
      end

      it 'too many request' do
        VCR.use_cassette('rate_limit_exceed') do
          expect do
            subject.send_sms('79998887766', 'test message')
          end.to raise_error(Smsc::TooManyRequests) { |error|
            expect(error.message).to eq('duplicate request, wait a minute')
          }
        end
      end

      it 'unknown error raised as client error' do
        VCR.use_cassette('unknown_error') do
          expect do
            subject.send_sms('79998887766', 'test message')
          end.to raise_error(Smsc::ClientError) { |error|
            expect(error.message).to eq('unknown error')
          }
        end
      end
    end

    context 'server' do
      shared_examples 'match_error_to_class' do |status_code, error_class|
        it "match #{status_code} to #{error_class}" do
          VCR.turned_off do
            stub_request(:any, /.*/).to_return(status: status_code)

            expect { subject.balance }.to raise_error(error_class)
          end
        end
      end

      include_examples 'match_error_to_class', 500, Smsc::InternalServerError
      include_examples 'match_error_to_class', 502, Smsc::BadGateway
      include_examples 'match_error_to_class', 503, Smsc::ServiceUnavailable
      include_examples 'match_error_to_class', 504, Smsc::GatewayTimeout
      include_examples 'match_error_to_class', 511, Smsc::ServerError
    end
  end
end
