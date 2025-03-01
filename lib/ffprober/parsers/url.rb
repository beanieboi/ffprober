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

      def initialize(url_to_parse, exec = Ffprober::Ffmpeg::Exec.new)
        raise ArgumentError, "#{url_to_parse} is not a valid URL" unless valid_url?(url_to_parse)

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
    end
  end
end
