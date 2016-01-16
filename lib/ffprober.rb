require_relative "ffprober/version"

autoload :JSON, "json"

module Ffprober
  class EmptyInput < StandardError; end
  class InvalidInputFileError < StandardError; end
  class NoFfprobeFound < StandardError; end
  class UnsupportedVersion < StandardError; end

  autoload :AudioStream, "ffprober/audio_stream"
  autoload :Chapter, "ffprober/chapter"
  autoload :DataStream, "ffprober/data_stream"
  autoload :DynamicInitializer, "ffprober/dynamic_initializer"
  autoload :FfprobeVersion, "ffprober/ffprobe_version"
  autoload :Format, "ffprober/format"
  autoload :Parser, "ffprober/parser"
  autoload :Stream, "ffprober/stream"
  autoload :SubtitleStream, "ffprober/subtitle_stream"
  autoload :VideoStream, "ffprober/video_stream"
  autoload :Wrapper, "ffprober/wrapper"

  module Ffmpeg
    autoload :Exec, "ffprober/ffmpeg/exec"
    autoload :Finder, "ffprober/ffmpeg/finder"
    autoload :Version, "ffprober/ffmpeg/version"
    autoload :VersionValidator, "ffprober/ffmpeg/version_validator"
  end

  module Parsers
    autoload :File, "ffprober/parsers/file"
    autoload :Json, "ffprober/parsers/json"
  end
end
