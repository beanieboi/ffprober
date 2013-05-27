# encoding: utf-8
require 'spec_helper'

describe Ffprober::FfprobeVersion do
  let(:before_one_zero) { Gem::Version.new("0.9.0") }
  let(:one_zero)        { Gem::Version.new("1.0.0") }
  let(:one_one)         { Gem::Version.new("1.1.0") }
  let(:after_one_zero)  { Gem::Version.new("1.9.0") }
  let(:latest)          { Gem::Version.new("1.2.1") }

  let(:ubuntu_version) do "ffprobe version 0.10.6-6:0.10.6-0ubuntu0jon1
    built on Nov 12 2012 12:53:40 with gcc 4.7.2
    configuration: --arch=amd64 --enable-pthreads --enable-runtime-cpudetect --extra-version='6:0.10.6-0ubuntu0jon1' --libdir=/usr/lib/x86_64-linux-gnu --disable-stripping --prefix=/usr --enable-bzlib --enable-libdc1394 --enable-libfreetype --enable-frei0r --enable-gnutls --enable-libgsm --enable-libmp3lame --enable-librtmp --enable-libopencv --enable-libopenjpeg --enable-libpulse --enable-libschroedinger --enable-libspeex --enable-libtheora --enable-vaapi --enable-vdpau --enable-libvorbis --enable-libvpx --enable-zlib --enable-gpl --enable-postproc --enable-libcdio --enable-x11grab --enable-libx264 --shlibdir=/usr/lib/x86_64-linux-gnu --enable-shared --disable-static
    libavutil      51. 35.100 / 51. 35.100
    libavcodec     53. 61.100 / 53. 61.100
    libavformat    53. 32.100 / 53. 32.100
    libavdevice    53.  4.100 / 53.  4.100
    libavfilter     2. 61.100 /  2. 61.100
    libswscale      2.  1.100 /  2.  1.100
    libswresample   0.  6.100 /  0.  6.100
    libpostproc    52.  0.100 / 52.  0.100"
  end

  let(:osx_homebrew_version) do "ffprobe version 1.2.0
     built on May 18 2013 15:54:36 with Apple LLVM version 4.2 (clang-425.0.28) (based on LLVM 3.2svn)
     configuration: --prefix=/usr/local/Cellar/ffmpeg/1.2.1 --enable-shared --enable-pthreads --enable-gpl --enable-version3 --enable-nonfree --enable-hardcoded-tables --enable-avresample --enable-vda --cc=cc --host-cflags= --host-ldflags= --enable-libx264 --enable-libfaac --enable-libmp3lame --enable-libxvid
     libavutil      52. 18.100 / 52. 18.100
     libavcodec     54. 92.100 / 54. 92.100
     libavformat    54. 63.104 / 54. 63.104
     libavdevice    54.  3.103 / 54.  3.103
     libavfilter     3. 42.103 /  3. 42.103
     libswscale      2.  2.100 /  2.  2.100
     libswresample   0. 17.102 /  0. 17.102
     libpostproc    52.  2.100 / 52.  2.100"
  end

  let(:osx_homebrew_version_one_zero) do "ffprobe version 1.0
     built on May 18 2013 15:54:36 with Apple LLVM version 4.2 (clang-425.0.28) (based on LLVM 3.2svn)
     configuration: --prefix=/usr/local/Cellar/ffmpeg/1.2.1 --enable-shared --enable-pthreads --enable-gpl --enable-version3 --enable-nonfree --enable-hardcoded-tables --enable-avresample --enable-vda --cc=cc --host-cflags= --host-ldflags= --enable-libx264 --enable-libfaac --enable-libmp3lame --enable-libxvid
     libavutil      52. 18.100 / 52. 18.100
     libavcodec     54. 92.100 / 54. 92.100
     libavformat    54. 63.104 / 54. 63.104
     libavdevice    54.  3.103 / 54.  3.103
     libavfilter     3. 42.103 /  3. 42.103
     libswscale      2.  2.100 /  2.  2.100
     libswresample   0. 17.102 /  0. 17.102
     libpostproc    52.  2.100 / 52.  2.100"
  end

  context 'validates the ffprobe version' do
    it '< 0.9' do
      Ffprober::FfprobeVersion.any_instance.stub(:version) { before_one_zero }
      Ffprober::FfprobeVersion.valid?.should be_true
    end

    it '1.0' do
      Ffprober::FfprobeVersion.any_instance.stub(:version) { one_zero }
      Ffprober::FfprobeVersion.valid?.should be_true
    end

    it '1.1' do
      Ffprober::FfprobeVersion.any_instance.stub(:version) { one_one }
      Ffprober::FfprobeVersion.valid?.should be_true
    end

    it '1.9' do
      Ffprober::FfprobeVersion.any_instance.stub(:version) { after_one_zero }
      Ffprober::FfprobeVersion.valid?.should be_false
    end

    it 'latest' do
      Ffprober::FfprobeVersion.any_instance.stub(:version) { latest }
      Ffprober::FfprobeVersion.valid?.should be_true
    end
  end

  describe 'detects the version of ffprobe' do
    describe 'on osx with homebrew' do

      it '1.2' do
        Ffprober::FfprobeVersion.any_instance.stub(:version_output) { osx_homebrew_version }

        version_check = Ffprober::FfprobeVersion.new
        version_check.version.should eq(Gem::Version.new("1.2.0"))
      end

      it '1.0' do
        Ffprober::FfprobeVersion.any_instance.stub(:version_output) { osx_homebrew_version_one_zero }

        version_check = Ffprober::FfprobeVersion.new
        version_check.version.should eq(Gem::Version.new("1.0"))
      end
    end

    it 'ubuntu' do
      Ffprober::FfprobeVersion.any_instance.stub(:version_output) { ubuntu_version }

      version_check = Ffprober::FfprobeVersion.new
      version_check.version.should eq(Gem::Version.new("0.10.6"))
    end
  end
end
