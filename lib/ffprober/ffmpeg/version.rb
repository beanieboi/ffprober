module Ffprober
  module Ffmpeg
    class Version
      def initialize(ffprobe_exec = Ffprober::Ffmpeg::Exec.new)
        @ffprobe_exec = ffprobe_exec
      end

      VERSION_REGEX = /^(ffprobe|avprobe|ffmpeg) version (\d+)\.?(\d+)\.?(\d+)*/
      NIGHTLY_REGEX = /^(ffprobe|avprobe|ffmpeg) version (N|git)-/
      VERSION_FALLBACK = [0, 0, 0].freeze

      def version
        @version ||= Gem::Version.new(parse_version.join('.'))
      end

      def nightly?
        !!(ffprobe_version_output =~ NIGHTLY_REGEX)
      end

      private

      def parse_version
        @parse_version ||= begin
          ffprobe_version_output.match(VERSION_REGEX) do |match|
            [match[2].to_i, match[3].to_i, match[4].to_i]
          end || VERSION_FALLBACK
        end
      end

      def ffprobe_version_output
        @ffprobe_exec.ffprobe_version_output
      end

      def to_s
        parse_version.join('.')
      end
    end
  end
end
