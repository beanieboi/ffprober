# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ffprober/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["beanieboi"]
  gem.email         = ["beanie@benle.de"]
  gem.description   = %q{a Ruby wrapper for ffprobe}
  gem.summary       = %q{a Ruby wrapper for ffprobe (part of ffmpeg)}
  gem.homepage      = "https://github.com/beanieboi/ffprober"

  gem.required_ruby_version     = ">= 1.9.2"
  gem.rubyforge_project         = "ffprober"

  gem.add_development_dependency "rspec", "~> 2.9"
  gem.add_development_dependency 'rake', '~> 0.9'

  gem.add_runtime_dependency 'multi_json', '~> 1.3'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ffprober"
  gem.require_paths = ["lib"]
  gem.version       = Ffprober::VERSION
end
