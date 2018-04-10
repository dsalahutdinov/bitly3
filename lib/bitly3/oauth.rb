# frozen_string_literal: true

require 'oauth2'

module Bitly3
  # OAuth authentication helper class
  class OAuth
    AUTHORIZE_URL = 'https://bitly.com'
    API_URL = 'https://api-ssl.bitly.com'

    attr_reader :consumer_key, :consumer_secret

    def initialize(consumer_key:, consumer_secret:)
      @consumer_key = consumer_key
      @consumer_secret = consumer_secret
    end

    def authorize_url(redirect_url:, state: nil)
      client(AUTHORIZE_URL).auth_code.authorize_url(
        redirect_uri: redirect_url,
        state: state
      )
    end

    def access_token(code:, redirect_url:)
      client(API_URL).auth_code.get_token(
        code,
        redirect_uri: redirect_url
      )
    end

    private

    def client(token_url = API_URL)
      ::OAuth2::Client.new(
        consumer_token,
        consumer_secret,
        site: token_url,
        token_url: '/oauth/access_token'
      )
    end
  end
end
