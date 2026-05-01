# typed: true
# frozen_string_literal: true

require 'test_helper'

module Ffprober
  module Parsers
    # rubocop:disable Metrics/ClassLength
    class UrlParserTest < Minitest::Test
      VALID_HTTP_URL = 'http://fakeurl.io/video.mp4'
      VALID_HTTPS_URL = 'https://fakeurl.io/video.mp4'
      FILE_URL = 'file:///localhost/video.mp4'
      UNESCAPED_HTTP_URL = 'http://fakeurl.io/video name.mp4'
      RTSP_URL = 'rtsp://fakeurl.io/stream'
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

      def setup
        @had_global = Ffprober.instance_variable_defined?(:@allowed_url_schemes)
        @previous_global = Ffprober.instance_variable_get(:@allowed_url_schemes) if @had_global
        Ffprober.remove_instance_variable(:@allowed_url_schemes) if @had_global
      end

      def teardown
        if Ffprober.instance_variable_defined?(:@allowed_url_schemes)
          Ffprober.remove_instance_variable(:@allowed_url_schemes)
        end
        Ffprober.instance_variable_set(:@allowed_url_schemes, @previous_global) if @had_global
      end

      def test_with_invalid_url
        assert_raises ArgumentError do
          UrlParser.new(INVALID_URL, allowed_schemes: %w[http https])
        end
      end

      def test_with_embedded_url
        assert_raises ArgumentError do
          UrlParser.new(EMBEDDED_URL, allowed_schemes: %w[http https])
        end
      end

      def test_with_a_http_url
        fake_exec = FakeExec.new
        url = UrlParser.new(VALID_HTTP_URL, fake_exec, allowed_schemes: %w[http https])

        assert_instance_of JsonParser, url.load
      end

      def test_with_unescaped_url
        fake_exec = FakeExec.new
        url = UrlParser.new(UNESCAPED_HTTP_URL, fake_exec, allowed_schemes: %w[http])

        assert_instance_of JsonParser, url.load
      end

      def test_raises_without_any_allowed_schemes_configured
        err = assert_raises ArgumentError do
          UrlParser.new(VALID_HTTP_URL)
        end
        assert_match(/allowed_schemes must be set/, err.message)
      end

      def test_raises_when_allowed_schemes_is_empty
        assert_raises ArgumentError do
          UrlParser.new(VALID_HTTP_URL, allowed_schemes: [])
        end
      end

      def test_raises_when_allowed_schemes_is_explicitly_nil
        err = assert_raises ArgumentError do
          UrlParser.new(VALID_HTTP_URL, allowed_schemes: nil)
        end
        assert_match(/cannot be nil/, err.message)
      end

      def test_raises_when_allowed_schemes_is_not_an_array
        err = assert_raises ArgumentError do
          UrlParser.new(VALID_HTTP_URL, allowed_schemes: 'http')
        end
        assert_match(/must be an Array/, err.message)
      end

      def test_raises_when_global_set_to_nil
        assert_raises ArgumentError do
          Ffprober.allowed_url_schemes = nil
        end
      end

      def test_raises_when_global_set_to_empty_array
        assert_raises ArgumentError do
          Ffprober.allowed_url_schemes = []
        end
      end

      def test_raises_when_global_set_to_non_array
        assert_raises ArgumentError do
          Ffprober.allowed_url_schemes = 'http'
        end
      end

      def test_scheme_not_in_allowlist_is_rejected
        assert_raises ArgumentError do
          UrlParser.new(FILE_URL, allowed_schemes: %w[http https])
        end
      end

      def test_explicit_allowlist_permits_file_scheme
        fake_exec = FakeExec.new
        url = UrlParser.new(FILE_URL, fake_exec, allowed_schemes: %w[file])

        assert_instance_of JsonParser, url.load
      end

      def test_global_config_is_used_when_no_kwarg
        Ffprober.allowed_url_schemes = %w[http https]

        fake_exec = FakeExec.new
        url = UrlParser.new(VALID_HTTPS_URL, fake_exec)

        assert_instance_of JsonParser, url.load
      end

      def test_per_call_kwarg_replaces_global_config
        Ffprober.allowed_url_schemes = %w[http https]

        fake_exec = FakeExec.new
        url = UrlParser.new(RTSP_URL, fake_exec, allowed_schemes: %w[rtsp])

        assert_instance_of JsonParser, url.load
      end

      def test_per_call_kwarg_can_narrow_global_config
        Ffprober.allowed_url_schemes = %w[http https rtsp]

        assert_raises ArgumentError do
          UrlParser.new(VALID_HTTP_URL, allowed_schemes: %w[file])
        end
      end
    end
    # rubocop:enable Metrics/ClassLength
  end
end
