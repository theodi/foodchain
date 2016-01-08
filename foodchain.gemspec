# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'foodchain/version'

Gem::Specification.new do |spec|
  spec.name          = 'foodchain'
  spec.version       = Foodchain::VERSION
  spec.authors       = ['pezholio']
  spec.email         = ['pezholio@gmail.com']
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'multichain'
  spec.add_dependency 'httparty', '~> 0.13.7'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.4'
  spec.add_development_dependency 'webmock', '~> 1.22'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'coveralls', '~> 0.8'

end
