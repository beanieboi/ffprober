require_relative "ffprober/version"

autoload :JSON, "json"

module Ffprober
  class NoFfprobeFound < StandardError; end
  class UnsupportedVersion < StandardError; end
  class EmptyInput < StandardError; end
  class InvalidInputFileError < StandardError; end

  autoload :DynamicInitializer, "ffprober/dynamic_initializer"
  autoload :Parser, "ffprober/parser"
  autoload :Format, "ffprober/format"
  autoload :Stream, "ffprober/stream"
  autoload :AudioStream, "ffprober/audio_stream"
  autoload :VideoStream, "ffprober/video_stream"
  autoload :DataStream, "ffprober/data_stream"
  autoload :SubtitleStream, "ffprober/subtitle_stream"
  autoload :Chapter, "ffprober/chapter"
  autoload :FfprobeVersion, "ffprober/ffprobe_version"
  autoload :Wrapper, "ffprober/wrapper"

  module Ffmpeg
    autoload :Finder, "ffprober/ffmpeg/finder"
    autoload :Version, "ffprober/ffmpeg/version"
    autoload :VersionValidator, "ffprober/ffmpeg/version_validator"
  end

  module Parsers
    autoload :File, "ffprober/parsers/file"
    autoload :Json, "ffprober/parsers/json"
  end
end
