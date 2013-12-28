require_relative '../lib/ffprober'

parser = Ffprober::Parser.from_file("spec/assets/301-extracting_a_ruby_gem.m4v")
parser.video_streams.first
