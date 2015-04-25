module Ffprober
  module Parsers
    class Json
      def initialize(json_to_parse)
        fail ArgumentError.new("No JSON input data") if json_to_parse.nil?
        @json_to_parse = json_to_parse
      end

      def json
        @json ||= JSON.parse(@json_to_parse, symbolize_names: true)
      end
    end
  end
end
