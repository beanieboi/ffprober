require_relative '../lib/ffprober'
require 'bundler'
Bundler.setup(:profiling)
require 'stackprof'

MODES = [:cpu, :wall, :object]

MODES.each do |mode|

  from_file_profile = StackProf.run(mode: mode) do
    Ffprober::Parser.from_file('../spec/assets/301-extracting_a_ruby_gem.m4v')
  end
  File.open("tmp/stackprof-from_file-#{mode}.dump", 'wb') { |f| f.write Marshal.dump(from_file_profile) }

  valid_profile = StackProf.run(mode: mode) do
    Ffprober::FfprobeVersion.valid?
  end
  File.open("tmp/stackprof-valid-#{mode}.dump", 'wb') { |f| f.write Marshal.dump(valid_profile) }

end
