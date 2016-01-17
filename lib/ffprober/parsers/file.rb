module Ffprober
  module Parsers
    class File
      def initialize(file_to_parse, exec = Ffprober::Ffmpeg::Exec.new)
        unless ::File.exist?(file_to_parse)
          fail ArgumentError, "File not found #{file_to_parse}"
        end

        @file_to_parse = file_to_parse
        @exec = exec
      end

      def load
        Ffprober::Parsers::Json.new(@exec.json_output(@file_to_parse))
      end
    end
  end
end
