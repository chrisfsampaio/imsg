# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'imsg/version'

Gem::Specification.new do |spec|
  spec.name          = "imsg"
  spec.version       = Imsg::VERSION
  spec.authors       = ["Christian Sampaio"]
  spec.email         = ["christian.fsampaio@gmail.com"]
  spec.date          = '2014-02-11'
  spec.summary       = "Chat using iMessage on your terminal!"
  spec.description   = "Tired of getting off your terminal screen to answer that dickheads friends of yours? You can curse them right on the terminal now!"
  spec.homepage      = 'https://github.com/chrisfsampaio/imsg'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   << 'imsg'
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_runtime_dependency "rb-appscript"
  spec.add_runtime_dependency "thor"
end
