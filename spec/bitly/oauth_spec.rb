# frozen_string_literal: true

RSpec.describe Bitly3::OAuth do
  let(:oauth) do
    described_class.new(
      consumer_key: '123', consumer_secret: '321'
    )
  end

  describe '#initialize' do
    it 'initializes with consumer_key and consumer_secret' do
      expect(oauth).to have_attributes(
        consumer_key: '123', consumer_secret: '321'
      )
    end
  end

  let(:callback_url) { ENV.fetch('BITLY_CALLBACK_URL') }

  describe '#authorize_url' do
    let(:authorize_url) do
      oauth.authorize_url(redirect_url: callback_url)
    end
    it do
      expect(authorize_url).to eq 'https://bitly.com/oauth/authorize?'\
        'client_id=123&redirect_uri=https%3A%2F%2Flocalhost%3A3000%2F'\
        'bitly%2Fcallback&response_type=code'
    end
  end

  describe '#access_token', vcr: { cassette_name: 'oauth/access_token' } do
    let(:oauth) do
      described_class.new(
        consumer_key: ENV.fetch('BITLY_CONSUMER_KEY'),
        consumer_secret: ENV.fetch('BITLY_CONSUMER_SECRET')
      )
    end
    let(:code) { ENV.fetch('BITLY_AUTH_CODE') }
    let(:access_token) do
      oauth.access_token(code: code, redirect_url: callback_url)
    end

    it do
      expect(access_token.token).to eq 'xxxx'
    end
  end
end
