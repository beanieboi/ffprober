# typed: strict
# frozen_string_literal: true

require 'shellwords'

module Ffprober
  module Ffmpeg
    class Exec
      extend T::Sig

      CHAPTER_SUPPORT = T.let(Gem::Version.new('2.0.0'), Gem::Version)

      sig { params(finder: T.any(Ffprober::Ffmpeg::Finder, T.untyped)).void }
      def initialize(finder = Ffprober::Ffmpeg::Finder.new)
        @finder = finder
        @ffprobe_version_output = T.let(nil, T.nilable(String))
      end

      sig { params(filename: String).returns(String) }
      def json_output(filename)
        `#{@finder.path} #{ffprobe_options} #{Shellwords.escape(filename)}`
      end

      sig { returns(String) }
      def ffprobe_version_output
        @ffprobe_version_output ||= begin
          if @finder.path.nil?
            ''
          else
            `#{@finder.path} -version`
          end
        end
      end

      sig { returns(String) }
      def ffprobe_options
        base_options = '-v quiet -print_format json -show_format'\
                       ' -show_streams -show_error'

        options = "#{base_options} -show_chapters" if ffprobe_version.version >= CHAPTER_SUPPORT

        options || base_options
      end

      sig { returns(Ffprober::Ffmpeg::Version) }
      def ffprobe_version
        Ffprober::Ffmpeg::Version.new(self)
      end
    end
  end
end
