# frozen_string_literal: true

RSpec.describe Bitly3::Testing do
  before { Bitly3::Testing.fake! }

  describe 'api fake methods' do
    let(:client) { Bitly3::Client.new('fake access token') }

    it do
      url = client.shorten('https://google.com')
      expect(url).to have_attributes(url: 'http://bit.ly/bitly3')
    end

    it do
      url = client.expand('http://bit.ly/bitly3')
      expect(url).to have_attributes(long_url: 'https://amplifr.com')
    end

    it do
      clicks = client.clicks('http://bit.ly/bitly3')
      expect(clicks).to have_attributes(links_click: 2)
    end
  end

  after { Bitly3::Testing.disable! }
end
