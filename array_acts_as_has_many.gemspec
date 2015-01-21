# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'array_acts_as_has_many/version'

Gem::Specification.new do |spec|
  spec.name          = "array_acts_as_has_many"
  spec.version       = ArrayActsAsHasMany::VERSION
  spec.authors       = ["fahchen"]
  spec.email         = ["dev.fah@gmail.com"]
  spec.summary       = %q{Makes PostgreSQL array act as has_many.}
  spec.description   = %q{ActiveRecord extension makes has_many parent keeps the children's ids in the PostgreSQL array column.}
  spec.homepage      = "https://github.com/fahchen/array_acts_as_has_many"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
