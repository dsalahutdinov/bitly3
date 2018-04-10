# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Bitly3::Client do
  describe '#initialize' do
    it 'initializes client with access_token, consumer_key, consumer_secret' do
      client = described_class.new('access_token')
      expect(client.access_token).to eq 'access_token'
    end
  end

  describe 'api methods' do
    let(:access_token) { ENV.fetch('BITLY_ACCESS_TOKEN') }
    let(:client) { described_class.new(access_token) }

    describe '#shorten', vcr: { cassette_name: 'client/shorten' } do
      let(:url) { client.shorten('https://github.com/dsalahutdinov/bitly3') }

      it 'shortens provided link and return link object' do
        expect(url).to have_attributes(
          url: 'http://bit.ly/2qn29sL'
        )
      end
    end

    describe '#expand', vcr: { cassette_name: 'client/expand' } do
      let(:url) { client.expand('http://bit.ly/2qn29sL') }

      it 'returns the previous link' do
        expect(url).to have_attributes(
          long_url: 'https://github.com/dsalahutdinov/bitly3'
        )
      end
    end

    describe '#clicks', vcr: { cassette_name: 'client/clicks' } do
      let(:clicks) { client.clicks('http://bit.ly/2qn29sL') }

      it 'returns clicks object' do
        expect(clicks).to have_attributes(
          link_clicks: 2,
          unit: 'day'
        )
      end
    end
  end
end
