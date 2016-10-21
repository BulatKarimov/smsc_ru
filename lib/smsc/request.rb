require 'addressable/template'
require_relative 'response'

module Smsc
  # Build url from template with specified parameters
  module Request
    # Smsc url template
    URL_TEMPLATE = '{scheme}://{host}/sys/{endpoint}.php{?params*}'.freeze

    private

    # @private
    def request(request_params)
      request_url = Addressable::Template.new(URL_TEMPLATE).expand(
        scheme: config.ssl ? 'https' : 'http',
        host: config.host,
        endpoint: request_params[:endpoint],
        params: request_params[:params]
      )

      response = connection(request_url).get
      Response.parse(response.body, request_params)
    end
  end
end
