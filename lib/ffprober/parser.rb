require 'shellwords'

module Ffprober
  class Parser
    def self.from_file(file_to_parse)
      if FfprobeVersion.invalid?
        fail UnsupportedVersion, "found version: #{FfprobeVersion.version}"
      end

      fail EmptyInput, file_to_parse if File.zero?(file_to_parse)

      file_parser = Ffprober::Parsers::File.new(file_to_parse)
      json_parser = file_parser.load
      Ffprober::Wrapper.new(json_parser.json)
    end

    def self.from_json(json_to_parse)
      json_parser = Ffprober::Parsers::Json.new(json_to_parse)
      Ffprober::Wrapper.new(json_parser.json)
    end
  end
end
