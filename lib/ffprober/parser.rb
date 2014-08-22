module Ffprober
  class Parser
    def self.from_file(file_to_parse)
      unless FfprobeVersion.valid?
        fail ArgumentError.new("no or unsupported ffprobe version found.\
                                (version: #{FfprobeVersion.new.version})")
      end

      unless File.exist?(file_to_parse)
        fail ArgumentError.new("File not found #{file_to_parse}")
      end

      json_output = `#{Ffprober.path} #{options} '#{file_to_parse}'`
      from_json(json_output)
    end

    def self.from_json(json_to_parse)
      parser = new
      parser.parse(json_to_parse)
      parser
    end

    def parse(json_to_parse)
      fail ArgumentError.new('No JSON input data') if json_to_parse.nil?
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

    def stream_by_codec(codec_type)
      streams.select { |stream| stream[:codec_type] == codec_type }
    end

    private

    def self.options
      options = '-v quiet -print_format json -show_format -show_streams'
      options << ' -show_chapters' if FfprobeVersion.version >= Gem::Version.new('2.0.0')
      options
    end

    def streams
      @json[:streams]
    end
  end
end
