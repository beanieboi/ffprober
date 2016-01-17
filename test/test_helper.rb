$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'simplecov'
SimpleCov.start

require 'ffprober'
require 'minitest/autorun'

def fake_ffprobe_version_path
  File.expand_path('../', __FILE__) + '/fake_ffprobe_version'
end

def fake_ffprobe_output_path
  File.expand_path('../', __FILE__) + '/fake_ffprobe_output'
end

def assets_path
  File.expand_path('../assets', __FILE__)
end
