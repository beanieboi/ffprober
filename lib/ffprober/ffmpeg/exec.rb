# frozen_string_literal: true
module Ffprober
  module Ffmpeg
    class Exec
      CHAPTER_SUPPORT = Gem::Version.new('2.0.0')

      def initialize(ffprobe_finder = Ffprober::Ffmpeg::Finder)
        @ffprobe_finder = ffprobe_finder
      end

      def json_output(file_to_parse)
        `#{@ffprobe_finder.path} #{ffprobe_options} #{Shellwords.escape(file_to_parse)}`
      end

      def ffprobe_version_output
        @ffprobe_version_output ||= begin
          if @ffprobe_finder.path.nil?
            ''
          else
            `#{@ffprobe_finder.path} -version`
          end
        end
      end

      def ffprobe_options
        options = '-v quiet -print_format json -show_format -show_streams'
        options = options + ' -show_chapters' if ffprobe_version.version >= CHAPTER_SUPPORT
        options
      end

      def ffprobe_version
        Ffprober::Ffmpeg::Version.new(self)
      end
    end
  end
end

