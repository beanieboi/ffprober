require_relative 'ffprober/version'
require_relative 'ffprober/parser'
require_relative 'ffprober/format'
require_relative 'ffprober/stream'
require_relative 'ffprober/audio_stream'
require_relative 'ffprober/video_stream'
require_relative 'ffprober/ffprobe_version'
require 'json'
require 'pry'

module Ffprober
  def self.path
    @path ||= begin
      path = ENV['PATH'].split(File::PATH_SEPARATOR).find do |path|
        File.executable?(File.join(path, executable_name))
      end

      path && File.expand_path(executable_name, path)
    end
  end

  def self.executable_name
    @executable_name ||= self.windows? ? 'ffprobe.exe' : 'ffprobe'
  end

  def self.windows?
    !!(RUBY_PLATFORM =~ /(mingw|mswin)/)
  end

  class InvalidInputFileError < ::StandardError; end
end
