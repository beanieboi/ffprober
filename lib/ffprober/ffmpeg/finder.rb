# frozen_string_literal: true

module Ffprober
  module Ffmpeg
    class Finder
      SEARCH_PATHS = ENV['PATH']

      def self.path
        raise Ffprober::NoFfprobeFound if executable_path.nil?
        @path ||= File.expand_path(executable_name, executable_path)
      end

      def self.executable_name
        @executable_name ||= windows? ? 'ffprobe.exe' : 'ffprobe'
      end

      def self.windows?
        !(RUBY_PLATFORM =~ /(mingw|mswin)/).nil?
      end

      def self.executable_path
        @executable_path ||= begin
          SEARCH_PATHS.split(File::PATH_SEPARATOR).detect do |path_to_check|
            File.executable?(File.join(path_to_check, executable_name))
          end
        end
      end
    end
  end
end
