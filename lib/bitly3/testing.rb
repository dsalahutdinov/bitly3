# frozen_string_literal: true

require 'bitly3'

module Bitly3
  # Supports stubs for testing
  class Testing
    class << self
      attr_accessor :__test_mode

      def __set_test_mode(mode)
        if block_given?
          current_mode = self.__test_mode
          begin
            self.__test_mode = mode
            yield
          ensure
            self.__test_mode = current_mode
          end
        else
          self.__test_mode = mode
        end
      end

      def disable!(&block)
        __set_test_mode(:disable, &block)
      end

      def fake!(&block)
        __set_test_mode(:fake, &block)
      end

      def fake?
        self.__test_mode == :fake
      end
    end
  end

  module ClientFaker
    def shorten(url)
      if Bitly3::Testing.fake?
        OpenStruct.new(url: 'http://bit.ly/bitly3')
      else
        super(url)
      end
    end

    def expand(url)
      if Bitly3::Testing.fake?
        OpenStruct.new(long_url: 'https://amplifr.com')
      else
        super(url)
      end
    end

    def clicks(url)
      if Bitly3::Testing.fake?
        OpenStruct.new(links_click: 2)
      else
        super(url)
      end
    end
  end
end
Bitly3::Client.prepend(Bitly3::ClientFaker)
