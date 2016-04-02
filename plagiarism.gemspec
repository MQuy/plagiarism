# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'plagiarism/version'

Gem::Specification.new do |spec|
  spec.name          = "plagiarism2"
  spec.version       = Plagiarism::VERSION
  spec.authors       = ["MQuy"]
  spec.email         = ["sugiacupit@gmail.com"]

  spec.summary       = %q{Check the unique content on internet.}
  spec.description   = %q{Check the unique content on internet from bing, google, yahoo and duckduckgo.}
  spec.homepage      = "https://github.com/MQuy/plagiarism"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency 'typhoeus', '~> 1.0'
  spec.add_dependency 'faraday', '~> 0.9.2'
  spec.add_dependency 'pragmatic_segmenter', '~> 0.3'
  spec.add_dependency 'nokogiri', '~> 1.6'
  spec.add_dependency 'thor', '~> 0.19.1'
end
