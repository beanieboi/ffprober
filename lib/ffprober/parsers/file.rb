module Ffprober
  module Parsers
    class File
      def initialize(file_to_parse)
        unless ::File.exist?(file_to_parse)
          fail ArgumentError.new("File not found #{file_to_parse}")
        end

        @file_to_parse = file_to_parse
      end

      def load
        json_output = `#{ffprobe_finder.path} #{options} '#{@file_to_parse}'`
        Ffprober::Parsers::Json.new(json_output)
      end

      private

      def options
        options = "-v quiet -print_format json -show_format -show_streams"
        options << " -show_chapters" if ffprobe_version.version >= Gem::Version.new("2.0.0")
        options
      end

      def ffprobe_version
        Ffprober::Ffmpeg::Version.new
      end

      def ffprobe_finder
        Ffprober::Ffmpeg::Finder
      end
    end
  end
end
