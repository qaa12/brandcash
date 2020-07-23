require 'dry-configurable'

module Brandcash
  class Client
    extend Dry::Configurable
    setting :api_key, 'test'
    setting :url, 'https://api.brand.cash/v2/'
    setting :logger, Logger.new(STDOUT)

    def apikey_info
      url = "api_clients/#{Brandcash::Client.config.api_key}"
      response = connection.get(url)
      response
    end

    def receipt(qr_string)
      url = "receipts/get?#{qr_string}&n=1"
      response = connection.get(url)
      Brandcash::Responses::Ticket.new(response)
    end

    private

    def connection
      @connection ||= Faraday.new(
        url: Brandcash::Client.config.url,
        headers: {
          'Content-Type' => 'application/json',
          'X-Api-Key' => Brandcash::Client.config.api_key
        },
      ) do |faraday|
        faraday.response :json, parser_options: { symbolize_names: true }
        faraday.use Faraday::Request::UrlEncoded
        faraday.use Faraday::Response::Logger, Brandcash::Client.config.logger, bodies: true
        faraday.options.open_timeout = 2
        faraday.options.timeout = 5
        faraday.adapter :net_http
      end
    end

  end
end
