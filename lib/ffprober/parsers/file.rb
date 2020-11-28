# typed: strict
# frozen_string_literal: true

module Ffprober
  module Parsers
    class FileParser
      extend T::Sig
      T::Array[Integer]

      sig {params(file_to_parse: String, exec: T.any(Ffprober::Ffmpeg::Exec, Ffprober::Parsers::FileParserTest::FakeExec)).void}
      def initialize(file_to_parse, exec = Ffprober::Ffmpeg::Exec.new)
        unless ::File.exist?(file_to_parse)
          raise ArgumentError, "File not found #{file_to_parse}"
        end

        @file_to_parse = file_to_parse
        @exec = exec
      end

      sig {returns(Ffprober::Parsers::JsonParser)}
      def load
        JsonParser.new(@exec.json_output(@file_to_parse))
      end
    end
  end
end
