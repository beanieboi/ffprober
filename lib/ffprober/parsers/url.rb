# typed: true
# frozen_string_literal: true

require 'uri'

module Ffprober
  module Parsers
    class UrlParser
      VALID_URI_REGEX = if RUBY_VERSION >= '3.2.0'
                          /\A#{URI::RFC2396_PARSER.make_regexp}\z/
                        else
                          /\A#{URI::DEFAULT_PARSER.make_regexp}\z/
                        end

      def initialize(url_to_parse, exec = Ffprober::Ffmpeg::Exec.new, allowed_schemes: Ffprober::NoScheme)
        raise ArgumentError, "#{url_to_parse} is not a valid URL" unless valid_url?(url_to_parse)

        validate_scheme!(url_to_parse, resolve_schemes(allowed_schemes))

        @url_to_parse = url_to_parse
        @exec = exec
      end

      def load
        JsonParser.new(@exec.json_output(@url_to_parse))
      end

      private

      def valid_url?(url)
        url.gsub(' ', '%20') =~ VALID_URI_REGEX
      end

      def resolve_schemes(allowed_schemes)
        return Ffprober.allowed_url_schemes if allowed_schemes.equal?(Ffprober::NoScheme)

        raise ArgumentError, 'allowed_schemes cannot be nil — pass an Array of scheme names' if allowed_schemes.nil?
        unless allowed_schemes.is_a?(Array)
          raise ArgumentError, "allowed_schemes must be an Array, got #{allowed_schemes.class}"
        end
        raise ArgumentError, 'allowed_schemes cannot be empty' if allowed_schemes.empty?

        allowed_schemes
      end

      def validate_scheme!(url, schemes)
        if schemes.nil?
          raise ArgumentError,
                'allowed_schemes must be set: pass `allowed_schemes:` to from_url, ' \
                'or configure `Ffprober.allowed_url_schemes = %w[http https]` once at boot'
        end

        return if allowed_scheme?(url, schemes)

        raise ArgumentError, "URL scheme is not allowed (allowed: #{schemes.join(', ')})"
      end

      def allowed_scheme?(url, allowed_schemes)
        scheme = URI.parse(url.gsub(' ', '%20')).scheme&.downcase
        allowed_schemes.map { |s| s.to_s.downcase }.include?(scheme)
      rescue URI::InvalidURIError
        false
      end
    end
  end
end
