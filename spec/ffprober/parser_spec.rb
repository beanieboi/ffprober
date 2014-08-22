# encoding: utf-8
require 'spec_helper'

def shared_specs
  describe 'format' do
    it 'should determine the correct filename' do
      expect(ffprobe.format.filename).to eq('spec/assets/sample video.m4v')
    end

    it 'should find the correct size' do
      expect(ffprobe.format.size).to eq('4611')
    end

    it 'should find the correct bit_rate' do
      expect(ffprobe.format.bit_rate).to eq('377950')
    end
  end

  describe 'audio_streams' do
    it 'should determine the correct number of audio streams' do
      expect(ffprobe.audio_streams.count).to eq(1)
    end

    it 'should determine the correct sample rate of the first audio stream' do
      expect(ffprobe.audio_streams.first.sample_rate).to eq('44100')
    end
  end

  describe 'video_streams' do
    it 'should determine the correct width of the first video streams' do
      expect(ffprobe.video_streams.first.width).to eq(480)
    end

    it 'should determine the correct width of the first video streams' do
      expect(ffprobe.video_streams.first.height).to eq(272)
    end

    it 'should determine the correct number of video streams' do
      expect(ffprobe.video_streams.count).to eq(1)
    end
  end
end

describe Ffprober::Parser do

  context 'from_file', if: Ffprober::FfprobeVersion.valid? do
    let(:ffprobe) { Ffprober::Parser.from_file('spec/assets/sample video.m4v') }

    shared_specs
  end

  context 'from_json' do
    let(:ffprobe) { Ffprober::Parser.from_json(File.read('spec/assets/sample video.json')) }

    shared_specs
  end

  context 'from invalid file', if: Ffprober::FfprobeVersion.valid? do
    let(:ffprobe) { Ffprober::Parser.from_file('spec/assets/empty_file') }

    describe 'format' do
      it 'should determine the correct filename' do
        expect { ffprobe.format.filename }.to raise_error
      end

      it 'should find the correct size' do
        expect { ffprobe.format.size }.to raise_error
      end

      it 'should find the correct bit_rate' do
        expect { ffprobe.format.bit_rate }.to raise_error
      end
    end
  end
end
