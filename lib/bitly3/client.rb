# frozen_string_literal: true

require 'httparty'
require 'oj'

module Bitly3
  # Bitly API client class
  class Client
    include HTTParty
    base_uri 'https://api-ssl.bitly.com'

    API_PREFIX = '/v3/'
    attr_accessor :access_token

    def initialize(access_token)
      @access_token = access_token
    end

    def shorten(long_url)
      response = get(:shorten, longUrl: long_url)
      OpenStruct.new(Oj.load(response.body)['data'])
    end

    def expand(short_url)
      response = get(:expand, shortUrl: short_url)
      OpenStruct.new(Oj.load(response.body)['data']['expand'].first)
    end

    def clicks(link)
      response = get(:'link/clicks', link: link)
      OpenStruct.new(Oj.load(response.body)['data'])
    end

    private

    def get(api_method, params = {})
      self.class.get(
        "#{API_PREFIX}#{api_method}",
        query: params.merge(access_token: access_token)
      )
    end
  end
end
