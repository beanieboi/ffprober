module Ffprober
  module Ffmpeg
    class Finder
      def self.path
        @path ||= begin
          path = ENV['PATH'].split(File::PATH_SEPARATOR).find do |path_to_check|
            File.executable?(File.join(path_to_check, executable_name))
          end

          path && File.expand_path(executable_name, path)
        end
      end

      def self.executable_name
        @executable_name ||= self.windows? ? "ffprobe.exe" : "ffprobe"
      end

      def self.windows?
        !!(RUBY_PLATFORM =~ /(mingw|mswin)/)
      end
    end
  end
end
