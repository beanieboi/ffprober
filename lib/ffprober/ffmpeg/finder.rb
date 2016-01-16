module Ffprober
  module Ffmpeg
    class Finder
      SEARCH_PATHS = ENV["PATH"]

      def self.path
        fail Ffprober::NoFfprobeFound if executable_path.nil?
        @path ||= File.expand_path(executable_name, executable_path)
      end

      def self.executable_name
        @executable_name ||= self.windows? ? "ffprobe.exe" : "ffprobe"
      end

      def self.windows?
        !!(RUBY_PLATFORM =~ /(mingw|mswin)/)
      end

      def self.executable_path
        @@executable_path ||= begin
          SEARCH_PATHS.split(File::PATH_SEPARATOR).detect do |path_to_check|
            File.executable?(File.join(path_to_check, executable_name))
          end
        end
      end
    end
  end
end
