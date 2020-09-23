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

tested with ffprobe version 0.9 upto 3.3

according to [ffmpeg changelog](http://git.videolan.org/?p=ffmpeg.git;a=blob_plain;f=Changelog) json output was added in version 0.9

[ffprobe documentation](http://www.ffmpeg.org/ffprobe.html)

## Improve FFMPEG version detection

help me collecting various version outputs of fprobe/ffmpeg

1. run `ffprobe -version` on your system
2. open an issue and send the output to me along with the expected version
3. profit

## Supported Rubies

Ffprober is tested under 2.4, 2.5, 2.6 and 2.7.

[![Build Status](https://github.com/beanieboi/ffprober/workflows/Ruby/badge.svg)](https://github.com/beanieboi/ffprober/actions?query=workflow%3ARuby)

[![Maintainability](https://api.codeclimate.com/v1/badges/34d393657d54b233ebbc/maintainability)](https://codeclimate.com/github/beanieboi/ffprober/maintainability)

[![Test Coverage](https://api.codeclimate.com/v1/badges/34d393657d54b233ebbc/test_coverage)](https://codeclimate.com/github/beanieboi/ffprober/test_coverage)

## Contributors

- Michael B. Kulik
- manderson
- rmoriz

## Contributing

see [CONTRIBUTING.md][contributing]

[contributing]: https://github.com/beanieboi/ffprober/blob/master/CONTRIBUTING.md

## License

Copyright (c) 2011 Benjamin Fritsch.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

