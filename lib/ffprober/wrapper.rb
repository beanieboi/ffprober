module Ffprober
  class Wrapper
    def initialize(json)
      @json = json
    end

    def format
      @format ||= Ffprober::Format.new(json[:format])
    end

    def video_streams
      @video_streams ||= stream_by_codec("video").map { |data| Ffprober::VideoStream.new(data) }
    end

    def audio_streams
      @audio_streams ||= stream_by_codec("audio").map { |data| Ffprober::AudioStream.new(data) }
    end

    def chapters
      @chapters ||= json[:chapters].map { |chapter| Ffprober::Chapter.new(chapter) }
    end

    def subtitle_streams
      @subtitle_streams ||= stream_by_codec("subtitle").map { |stream| Ffprober::SubtitleStream.new(stream) }
    end

    private

    def stream_by_codec(codec_type)
      streams.select { |stream| stream[:codec_type] == codec_type }
    end

    def streams
      json[:streams]
    end

    def json
      @json
    end
  end
end
