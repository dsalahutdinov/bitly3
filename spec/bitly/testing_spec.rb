# frozen_string_literal: true

RSpec.describe Bitly3::Testing do
  before { Bitly3::Testing.fake! }

  describe Bitly3::Testing::Client do
    let(:client) { Bitly3::Client.new('fake access token') }

    it do
      url = client.shorten('https://stackoverflow.com/users')
      expect(url).to have_attributes(url: 'http://bit.ly/bitly3')
    end

    it do
      url = client.expand('http://bit.ly/bitly3')
      expect(url).to have_attributes(long_url: 'https://stackoverflow.com/users')
    end

    it do
      clicks = client.clicks('http://bit.ly/bitly3')
      expect(clicks).to have_attributes(links_click: 2)
    end
  end

  describe Bitly3::Testing::OAuth do
    let(:oauth) do
      Bitly3::OAuth.new(consumer_key: '123', consumer_secret: '321')
    end

    it do
      access_token = oauth.access_token(
        code: '234', redirect_url: 'http://some.url'
      )

      expect(access_token).to eq 'fake_access_token'
    end
  end

  after { Bitly3::Testing.disable! }
end
