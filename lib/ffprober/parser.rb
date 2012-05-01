module Ffprober
  class Parser
    @@ffprobe_path = `which ffprobe`
    @@options = '-v quiet -print_format json -show_format -show_streams'

    def self.from_file(file_to_parse)
      json_output = `#{@@ffprobe_path} #{@@options} #{@file_to_parse}`
      from_json(json_output)
    end

    def self.from_json(json_to_parse)
      parser = self.new
      parser.parse(json_to_parse)
      parser
    end

    def parse(json_to_parse)
      raise ArgumentError.new("No JSON found") if json_to_parse.nil?
      @video_json = MultiJson.load(json_to_parse, :symbolize_keys => true)
    end

    def format
      Ffprober::Format.new(@video_json[:format])
    end

    def video_streams
      @video_json[:streams].select { |stream| stream[:codec_type] == 'video'}.map do |s|
        Ffprober::VideoStream.new(s)
      end
    end

    def audio_streams
      @video_json[:streams].select { |stream| stream[:codec_type] == 'audio'}.map do |s|
        Ffprober::AudioStream.new(s)
      end
    end
  end
end
