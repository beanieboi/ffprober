# typed: strict
# frozen_string_literal: true

module Ffprober
  module Ffmpeg
    class Finder
      extend T::Sig
      SEARCH_PATHS = T.let(ENV['PATH'], T.nilable(String))

      sig {returns(String)}
      attr_reader :executable_name

      sig {void}
      def initialize
        @executable_name = windows? ? T.let('ffprobe.exe', String) : T.let('ffprobe', String)
      end

      sig {returns(String)}
      def path
        raise Ffprober::NoFfprobeFound, 'ffprobe executable not found' if executable_path.nil?
        @path ||= File.expand_path(executable_name, executable_path)
      end

      sig {returns(T::Boolean)}
      def windows?
        !(RUBY_PLATFORM =~ /(mingw|mswin)/).nil?
      end

      sig {returns(String)}
      def executable_path
        @executable_path ||= begin
          T.must(SEARCH_PATHS).split(File::PATH_SEPARATOR).detect do |path_to_check|
            File.executable?(File.join(path_to_check, executable_name))
          end
        end
      end
    end
  end
end
