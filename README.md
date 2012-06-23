# FfprobeR

a Ruby wrapper for ffprobe (which is part of ffmpeg)
ffprobe gathers information from multimedia streams and prints it in human- and machine-readable fashion.


## Installation

Add this line to your application's Gemfile:

    gem 'ffprober'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ffprober

## Usage

    require 'ffprober'
    ffprobe = Ffprober::Parser.from_file("my_awesome_video.mp4")
    ffprobe.size #=> 44772490

## FFMPEG version

tested with ffprobe version 0.10.2 and 0.11.1
according to [ffmpeg changelog](http://git.videolan.org/?p=ffmpeg.git;a=blob_plain;f=Changelog) json out was added in version 9

## Supported Rubies

OmniAuth Vimeo is tested under 1.9.2, 1.9.3, JRuby (1.9mode) and Rubinius (1.9mode).

[![Build Status](https://secure.travis-ci.org/beanieboi/ffprober.png?branch=master)](http://travis-ci.org/beanieboi/ffprober)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Copyright (c) 2011 Benjamin Fritsch.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

