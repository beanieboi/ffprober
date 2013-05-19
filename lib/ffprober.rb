require "ffprober/version"
require "ffprober/parser"
require "ffprober/format"
require "ffprober/stream"
require "ffprober/audio_stream"
require "ffprober/video_stream"
require "ffprober/ffprobe_version"
require "json"

module Ffprober
  def self.path
    name = 'ffprobe'

    path = ENV['PATH'].split(File::PATH_SEPARATOR).find do |path|
      File.executable?(File.join(path, name))
    end

    path && File.expand_path(name, path)
  end

  class InvalidInputFileError < ::StandardError; end
end
