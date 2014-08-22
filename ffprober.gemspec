# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ffprober/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["beanieboi"]
  gem.email         = ["beanie@benle.de"]
  gem.description   = %q{a Ruby wrapper for ffprobe}
  gem.summary       = %q{a Ruby wrapper for ffprobe (part of ffmpeg)}
  gem.homepage      = "https://github.com/beanieboi/ffprober"

  gem.required_ruby_version     = ">= 1.9.3"
  gem.rubyforge_project         = "ffprober"

  gem.licenses      = ['MIT']

  gem.add_development_dependency "rspec", "~> 3.0"

  gem.files         = `git ls-files`.split("\n")
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ffprober"
  gem.require_paths = ["lib"]
  gem.version       = Ffprober::VERSION
end
