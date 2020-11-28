# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'simplecov'
SimpleCov.start

require 'ffprober'
require 'minitest/autorun'

def fake_ffprobe_version_path
  "#{File.expand_path(__dir__)}/fake_ffprobe_version"
end

def fake_ffprobe_output_path
  "#{File.expand_path(__dir__)}/fake_ffprobe_output"
end

def assets_path
  File.expand_path('assets', __dir__)
end
