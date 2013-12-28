require_relative '../lib/ffprober'
require 'bundler'
Bundler.setup(:profiling)
require 'benchmark/ips'

Benchmark.ips do |x|
  x.report("cached") { Ffprober::Parser.from_file("../spec/assets/301-extracting_a_ruby_gem.m4v") }
  x.report("valid?") { Ffprober::FfprobeVersion.valid? }
end
