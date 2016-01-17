require_relative '../lib/ffprober'

parser = Ffprober::Parser.from_file("../spec/assets/s'ample video.m4v")
puts parser.video_streams.inspect
