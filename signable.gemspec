# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'signable/version'

Gem::Specification.new do |spec|
  spec.name          = "signable"
  spec.version       = Signable::VERSION
  spec.authors       = ["Anthony Laibe"]
  spec.email         = ["anthony@laibe.cc"]
  spec.summary       = %q{The signable client provides a simple Ruby interface to the Signable API.}
  spec.description   = %q{The signable client provides a simple Ruby interface to the Signable API.}
  spec.homepage      = "https://github.com/smartpension/signable"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake",    "~> 10.4"
  spec.add_development_dependency "rspec",   "~> 3.2"

  spec.add_dependency "activesupport",       "> 4.2"
  spec.add_dependency "httparty",            "~> 0.13"

end
