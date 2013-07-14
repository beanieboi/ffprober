0.3.3
-----------
support for ffmpeg 2.0

0.3.2
-----------
detect git-based installs of ffmpeg

0.3.1
-----------
fixed version output call

0.3.0
-----------
- correctly detect ffprobe path on windows
- correctly detect avprobe
- detect nighlt builds
- refactor ffprobe version detection (+spec)

0.2.3
-----------
- Raise error if input file is invalid (InvalidInputFileError)
- Added support for Ffmpeg 1.1.4 and 1.2.1

0.2.2
-----------
- Added Caching to instantiated Stream Objects
- Switched from attr_reader to of attr_accessor in stream classes

0.2.1
-----------
- Refactored Ffmpeg version check
- Convert to ruby 1.9 hash syntax
- Bumped minmun required ruby version to 1.9.3
- JSON input will be parsed lazily
- Moved Ffprobe path finder into Ffprober Module

0.2.0
-----------
- Droped ruby 1.8 support
- Switched from multi_json to json
- Updated travis config

0.1.7
-----------
- Added support for Ffmpeg 1.1.4 and 1.2

0.1.6
-----------
- added bit rate attribute to video stream
- Added support for Ffmpeg 1.1.3

0.1.5
-----------
- Added support for Ffmpeg 1.1.2

0.1.4
-----------
- Added support for Ffmpeg 1.1.1
- Bumped rake dependency to 0.10

0.1.3
-----------
- Added support for Ffmpeg 1.1 and 1.0.1

0.1.1
-----------
- Added support for Ffmpeg 1.0
- Added tests for ffmpeg version checker
- Updated README

0.1.0
-----------
- Added missing License to README
- Improved Ffmpeg version detection
- Updated README

0.0.2
-----------
- first working version (supports Ffmpeg 0.10.2)
