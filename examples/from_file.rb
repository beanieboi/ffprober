# frozen_string_literal: true

require_relative '../lib/ffprober'

parser = Ffprober::Parser.from_file("../test/assets/s'ample video.m4v")
puts parser.video_streams.inspect
