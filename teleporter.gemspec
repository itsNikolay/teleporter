# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'teleporter/version'

Gem::Specification.new do |spec|
  spec.name          = "teleporter"
  spec.version       = Teleporter::VERSION
  spec.authors       = ["Ponomarev Nikolay"]
  spec.email         = ["itsnikolay@gmail.com"]
  spec.summary       = %q{Generators for a fresh Rails application}
  spec.description   = %q{Generators for a fresh Rails application}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "railties"
  spec.add_runtime_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
