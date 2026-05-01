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

### Probing URLs

`from_url` needs you to say which URL schemes are ok. previously we accepted all schemes.

ffprobe speaks a lot of protocols (`file://`, `concat:`, `gopher://`, `rtsp://`, ...) and some of them happily read local files or hit internal services if you pass them a user-controlled URL.

set it once at boot:

    Ffprober.allowed_url_schemes = %w[http https]
    Ffprober::Parser.from_url("https://example.com/clip.mp4")

or per call:

    Ffprober::Parser.from_url("rtsp://example.com/stream", allowed_schemes: %w[rtsp])
    Ffprober::Parser.from_url("file:///srv/media/clip.mp4", allowed_schemes: %w[file])

without either, `from_url` raises `ArgumentError`.

the per-call kwarg replaces the global, it does not merge with it. two reasons:

- you can narrow per call. a global of `%w[http https rtsp]` is fine for most code, but if one endpoint should only ever take `file://`, merge semantics make that impossible.
- what you read is what you get. seeing `allowed_schemes: %w[rtsp]` at a call site and having it actually mean `%w[http https rtsp]` is exactly the action-at-a-distance that lets SSRF bugs slip in.

if you really want the union at a specific call site, just write it:

    Ffprober::Parser.from_url(url, allowed_schemes: Ffprober.allowed_url_schemes + %w[rtsp])

migrating from 2.x: older versions accepted any scheme ffprobe understood. the minimum migration is one line at boot — `Ffprober.allowed_url_schemes = %w[http https]` — plus a per-call `allowed_schemes:` anywhere you actually probe `file://`, `rtsp://` etc.

#### what the allowlist does and does not do

the allowlist closes scheme-based local file disclosure (`file://`, `concat:`, `subfile,`, `gopher://` and friends). it does **not** close SSRF when you allowlist `http`/`https` — a user-controlled URL like `http://169.254.169.254/` (cloud metadata) or `http://localhost:6379/` (internal services) still goes through. if you accept untrusted URLs, you also need host/IP filtering on top, with DNS-rebinding mitigations. ffprobe also follows HTTP redirects, so the URL you check is not necessarily the URL it ends up fetching.

a few schemes are transitive — `concat:` and `subfile,` wrap other URLs, so `concat:file:///etc/passwd|...` parses with scheme `concat` and passes the allowlist. allowlisting `concat` effectively allowlists everything it can nest. don't allow it for untrusted input.

## FFMPEG version

tested with ffprobe version 0.9 upto 4.3.1

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
