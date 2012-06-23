module Ffprober
  class Parser
    @@options = '-v quiet -print_format json -show_format -show_streams'

    def self.from_file(file_to_parse)
      raise ArgumentError.new("found unsupported ffprobe version") unless ffprobe_version_valid?

      json_output = `#{ffprobe_path} #{@@options} #{file_to_parse}`
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

    def self.ffprobe_version_valid?
      ffprobe_version[:minor] > 9
    end

    def self.ffprobe_version
      version = `#{ffprobe_path} -version`.match(/^ffprobe version (?:(\d+)\.)?(?:(\d+)\.)?(\*|\d+)$/)
      major, minor, patch = version[1].to_i, version[2].to_i, version[3].to_i
      {major: major, minor: minor, patch: patch}
    end

    def self.ffprobe_path
      name = 'ffprobe'

      if File.executable? name
        cmd
      else
        path = ENV['PATH'].split(File::PATH_SEPARATOR).find { |path|
          File.executable? File.join(path, name)
        }
        path && File.expand_path(name, path)
      end
    end
  end
end
