# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bit_vector/version'

Gem::Specification.new do |spec|
  spec.name          = "bit_vector"
  spec.version       = BitVector::VERSION
  spec.authors       = ["Juan Azambuja"]
  spec.email         = ["juan@wyeworks.com"]
  spec.summary       = %q{Bit Vector representation and managing of integer fields.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
