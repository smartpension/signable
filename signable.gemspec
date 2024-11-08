# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'signable/version'

Gem::Specification.new do |spec|
  spec.name          = 'signable'
  spec.version       = Signable::VERSION
  spec.authors       = ['Anthony Laibe']
  spec.email         = ['anthony@laibe.cc']
  spec.summary       = 'The signable client provides a simple Ruby interface to the Signable API.'
  spec.description   = 'The signable client provides a simple Ruby interface to the Signable API.'
  spec.homepage      = 'https://github.com/smartpension/signable'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 3.1.0'

  spec.add_development_dependency 'bundler', '~> 2.5'
  spec.add_development_dependency 'pry', '~> 0.14.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.13'
  spec.add_development_dependency 'rubocop', '~> 1.66'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.12'
  spec.add_development_dependency 'vcr', '~> 6.0'
  spec.add_development_dependency 'webmock', '~> 3.8.1'

  spec.add_dependency 'activesupport', '>= 7.0'
  spec.add_dependency 'httparty', '~> 0.13'
end
