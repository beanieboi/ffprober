# typed: strict
# frozen_string_literal: true

module Ffprober
  module Parsers
    class FileParser
      extend T::Sig

      sig do
        params(
          file_to_parse: String,
          exec: T.any(Ffprober::Ffmpeg::Exec, T.untyped)
        ).void
      end
      def initialize(file_to_parse, exec = Ffprober::Ffmpeg::Exec.new)
        raise ArgumentError, "File not found #{file_to_parse}" unless ::File.exist?(file_to_parse)

        @file_to_parse = file_to_parse
        @exec = exec
      end

      sig { returns(Ffprober::Parsers::JsonParser) }
      def load
        JsonParser.new(@exec.json_output(@file_to_parse))
      end
    end
  end
end
