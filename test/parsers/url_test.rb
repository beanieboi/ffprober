# typed: true
# frozen_string_literal: true

require 'test_helper'

module Ffprober
  module Parsers
    class UrlParserTest < Minitest::Test
      VALID_HTTP_URL = 'http://fakeurl.io/video.mp4'
      VALID_FILE_URL = 'file:///localhost/video.mp4'
      UNESCAPED_URL = 'file:///localhost/video name.mp4'
      INVALID_URL = 'NOT_A_URL'
      EMBEDDED_URL = 'NOT_A_URLhttp://fakeurl.io/video.mp4NOT_A_URL'

      class FakeExec
        def initialize
          @json_output = nil
        end

        def json_output(_url_to_parse)
          @json_output || '{}'
        end
      end

      def test_with_invalid_url
        assert_raises ArgumentError do
          UrlParser.new(INVALID_URL)
        end
      end

      def test_with_embedded_url
        assert_raises ArgumentError do
          UrlParser.new(EMBEDDED_URL)
        end
      end

      def test_with_a_http_url
        fake_exec = FakeExec.new
        http_url = VALID_HTTP_URL
        url = UrlParser.new(http_url, fake_exec)
        assert_instance_of JsonParser, url.load
      end

      def test_with_unescaped_url
        fake_exec = FakeExec.new
        http_url = UNESCAPED_URL
        url = UrlParser.new(http_url, fake_exec)
        assert_instance_of JsonParser, url.load
      end

      def test_with_a_file_url
        fake_exec = FakeExec.new
        file_url = VALID_FILE_URL
        url = UrlParser.new(file_url, fake_exec)
        assert_instance_of JsonParser, url.load
      end
    end
  end
end
