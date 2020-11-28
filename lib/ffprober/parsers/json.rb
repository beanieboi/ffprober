# typed: true
# frozen_string_literal: true

module Ffprober
  module Parsers
    class JsonParser
      def initialize(json_to_parse)
        raise ArgumentError, 'No JSON input data' if json_to_parse.nil?
        @json_to_parse = json_to_parse
      end

      def json
        @json ||= JSON.parse(@json_to_parse, symbolize_names: true)
      end
    end
  end
end
