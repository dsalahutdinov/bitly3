# frozen_string_literal: true

require 'bundler/setup'
require 'byebug'
require 'webmock/rspec'
require 'dotenv/load'
require 'vcr'
require 'bitly3'
require 'bitly3/testing'

VCR.configure do |c|
  c.configure_rspec_metadata!

  %w[BITLY_CONSUMER_KEY BITLY_CONSUMER_SECRET BITLY_ACCESS_TOKEN].each do |key|
    c.filter_sensitive_data("<<#{key}>>") { ENV.fetch(key) }
  end

  c.default_cassette_options = {
    serialize_with: :json,
    preserve_exact_body_bytes: true,
    decode_compressed_response: true,
    record: :once
  }
  c.hook_into :webmock
  c.cassette_library_dir = 'spec/cassettes'
end

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'

  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
