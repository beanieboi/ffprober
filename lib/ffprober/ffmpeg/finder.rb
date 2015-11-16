module Ffprober
  module Ffmpeg
    class Finder
      def self.path
        @path ||= File.expand_path(executable_name, executable_path)
      end

      def self.executable_name
        @executable_name ||= self.windows? ? "ffprobe.exe" : "ffprobe"
      end

      def self.windows?
        !!(RUBY_PLATFORM =~ /(mingw|mswin)/)
      end

      private

      def self.executable_path
        path = ENV["PATH"].split(File::PATH_SEPARATOR).detect do |path_to_check|
          File.executable?(File.join(path_to_check, executable_name))
        end
        fail Ffprober::NoFfprobeFound if path.nil?
        path
      end
    end
  end
end
