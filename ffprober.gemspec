# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ffprober/version'

Gem::Specification.new do |spec|
  spec.name          = 'ffprober'
  spec.version       = Ffprober::VERSION
  spec.authors       = ['beanieboi']
  spec.email         = ['beanie@benle.de']

  spec.description   = 'a Ruby wrapper for ffprobe'
  spec.summary       = 'a Ruby wrapper for ffprobe (part of ffmpeg)'
  spec.homepage      = 'https://github.com/beanieboi/ffprober'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.0'

  spec.add_development_dependency 'minitest', '~> 5'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rubocop', '~> 1'
end
