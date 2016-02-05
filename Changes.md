0.4.7 / 2015-11-XX
===================

* autoload, reduce initial object count by 3k
* refactorings, clean up warnings etc.
* remove check for maximum ffprober version, makes upgrading ffmpeg way easier

0.4.6 / 2015-11-12
===================

* support for ffmpeg 2.8.1
* support for data streams

0.4.5 / 2015-09-17
===================

* support for ffmpeg 2.7.2

0.4.4 / 2015-06-30
===================

* fix bug handling file with single quotes in the filename (thanks kaczowkad)

0.4.3 / 2015-06-22
===================

* add support for ffmpeg 2.6.3

0.4.2 / 2015-03-27
===================

 * add support for ffmpeg 2.5.4
 * add support for subtitle streams
 * update Changes.md

0.4.1 / 2014-08-27
==================

 * add support for ffmpeg 2.3.3
 * update Changes.md
 * add code climate coverage
 * move recurring initialize into a module

0.4.0 / 2014-08-22
==================

 * update sample video
 * set 2.3.2 as new max version
 * Merge pull request #42 from beanieboi/feature/chapters-new
 * warn if file to parse does not exist
 * add Chapters
 * Merge pull request #41 from beanieboi/feature/refator-specs
 * update ruby-version to 2.1.2
 * share specs and add sample json with chapters
 * use self.options
 * Merge pull request #40 from beanieboi/feature/refactor
 * set max version to 2.2.2
 * fix variable shadowing
 * allow all object attributes, smaller cleanup
 * Merge pull request #39 from beanieboi/feature/upgrade-rspec
 * Merge pull request #38 from mbkulik/ffmpeg-2.2.2-support
 * update Changes.md
 * relax rspec dependency and add a sample spec_helper
 * fix shadowing path in ffprober.rb:15
 * enable rspec warnings
 * add CONTRIBUTING.md
 * Update README.md
 * some code style fixes

0.3.7 / 2014-04-13
==================

- upgrade to rspec 3
- support for ffmpeg 2.1.4
- support for ffmpeg 2.2.0

0.3.6 / 2013-12-27
==================

- switch to ruby 2.1 by default
- remove rake
- add codeclimate badge
- update contributors
- fix builds on Rubinius
- wrap file path in quotes

0.3.5 / 2013-12-02
==================

- support for ffmpeg 2.0.2
- support for ffmpeg 2.1.1

0.3.4 / 2013-08-16
==================

- fix exception when no ffprobe is installed
- support for ffmpeg 2.0.1

0.3.3 / 2013-07-15
==================

- support for ffmpeg 2.0

0.3.2 / 2013-06-26
==================

- detect git-based installs of ffmpeg

0.3.1 / 2013-06-25
==================

- fixed version output call

0.3.0 / 2013-06-02
==================

- correctly detect ffprobe path on windows
- correctly detect avprobe
- detect nighlt builds
- refactor ffprobe version detection (+spec)

0.2.3 / 2013-05-18
==================

- Raise error if input file is invalid (InvalidInputFileError)
- Added support for Ffmpeg 1.1.4 and 1.2.1

0.2.2 / 2013-05-15
==================

- Added Caching to instantiated Stream Objects
- Switched from attr_reader to of attr_accessor in stream classes

0.2.1 / 2013-05-14
==================

- Refactored Ffmpeg version check
- Convert to ruby 1.9 hash syntax
- Bumped minmun required ruby version to 1.9.3
- JSON input will be parsed lazily
- Moved Ffprobe path finder into Ffprober Module

0.2.0 / 2013-05-13
==================

- Droped ruby 1.8 support
- Switched from multi_json to json
- Updated travis config

0.1.7 / 2013-03-19
==================

- Added support for Ffmpeg 1.1.4 and 1.2

0.1.6 / 2013-02-25
==================

- added bit rate attribute to video stream
- Added support for Ffmpeg 1.1.3

0.1.5 / 2013-02-08
==================

- Added support for Ffmpeg 1.1.2

0.1.4 / 2013-02-07
==================

- Added support for Ffmpeg 1.1.1
- Bumped rake dependency to 0.10

0.1.3 / 2013-01-12
==================

- Added support for Ffmpeg 1.1 and 1.0.1

0.1.1 / 2012-11-08
==================

- Added support for Ffmpeg 1.0
- Added tests for ffmpeg version checker
- Updated README

0.1.0 / 2012-06-23
==================

- Added missing License to README
- Improved Ffmpeg version detection
- Updated README

0.0.2 / 2012-05-01
==================

- first working version (supports Ffmpeg 0.10.2)
