# typed: true
# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
require 'test_helper'

module Ffprober
  module Ffmpeg
    class VersionTest < Minitest::Test
      extend T::Sig
      class FakeExec
        attr_writer :output

        def ffprobe_version_output
          @output
        end
      end

      sig { returns(Dir) }
      def test_version_output
        exec = FakeExec.new

        Dir.new('test/assets/version_outputs').each do |entry|
          next if ['.', '..', '.DS_Store'].include?(entry)

          _, expected_version = entry.split('-')

          version_output = File.read("test/assets/version_outputs/#{entry}")
          exec.output = version_output

          ffprobe_version = Ffprober::Ffmpeg::Version.new(exec)

          if expected_version == 'nightly'
            assert ffprobe_version.nightly?
          else
            assert_equal(
              Gem::Version.new(T.must(expected_version).tr('_', '.')),
              ffprobe_version.version
            )
          end
        end
      end
    end
  end
end
# rubocop:enable Metrics/MethodLength
