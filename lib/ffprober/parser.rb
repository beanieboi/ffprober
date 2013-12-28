module Ffprober
  class Parser
    @@options = '-v quiet -print_format json -show_format -show_streams'

    def self.from_file(file_to_parse)
      unless FfprobeVersion.valid?
        raise ArgumentError.new("no or unsupported ffprobe version found.\
                                (version: #{FfprobeVersion.new.version.to_s})")
      end

      json_output = `#{Ffprober.path} #{@@options} '#{file_to_parse}'`
      from_json(json_output)
    end

    def self.from_json(json_to_parse)
      parser = self.new
      parser.parse(json_to_parse)
      parser
    end

    def parse(json_to_parse)
      raise ArgumentError.new("No JSON input data") if json_to_parse.nil?
      @json = JSON.parse(json_to_parse, symbolize_names: true)
    end

    def format
      @format ||= Ffprober::Format.new(@json[:format])
    end

    def video_streams
      @video_streams ||= stream_by_codec('video').map { |stream| Ffprober::VideoStream.new(stream) }
    end

    def audio_streams
      @audio_streams ||= stream_by_codec('audio').map { |stream| Ffprober::AudioStream.new(stream) }
    end

    private

    def stream_by_codec(codec_type)
      streams.select { |stream| stream[:codec_type] == codec_type }
    end

    def streams
      @json[:streams]
    end
  end
end
