
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jekyll-crds/version"

Gem::Specification.new do |spec|
  spec.name          = "jekyll-crds"
  spec.version       = Jekyll::Crds::VERSION
  spec.authors       = ["Ample"]
  spec.email         = ["taylor@helloample.com"]

  spec.summary       = "Jekyll plugins for Crossroads"
  spec.license       = 'BSD-3'

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'jekyll'
  spec.add_dependency 'httparty'
  spec.add_dependency 'activesupport'
  spec.add_dependency 'curb'
end
