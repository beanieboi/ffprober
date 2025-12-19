# frozen_string_literal: true

module Ffprober
  module Ffmpeg
    class Finder
      SEARCH_PATHS = ENV.fetch('PATH', nil)

      attr_reader :executable_name

      def initialize
        @executable_path = nil
        @executable_name = executable_name_picker
        @path = nil
      end

      def path
        raise Ffprober::NoFfprobeFound, 'ffprobe executable not found' if executable_path.nil?

        @path ||= File.expand_path(executable_name, executable_path)
      end

      def windows?
        !(RUBY_PLATFORM =~ /(mingw|mswin)/).nil?
      end

      def executable_name_picker
        if windows?
          'ffprobe.exe'
        else
          'ffprobe'
        end
      end

      def executable_path
        @executable_path ||= SEARCH_PATHS.split(File::PATH_SEPARATOR).detect do |path_to_check|
          File.executable?(File.join(path_to_check, executable_name))
        end
      end
    end
  end
end
