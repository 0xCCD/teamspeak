# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'teamspeak/version'

Gem::Specification.new do |spec|
  spec.name          = "teamspeak"
  spec.version       = Teamspeak::VERSION
  spec.authors       = ["Christian Lallemand"]
  spec.email         = ["kontakt@cc-designz.de"]
  spec.summary       = %q{Little Connector for Teamspeak3 Server}
  spec.homepage      = "http://git.cc-designz.de/public/projects"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
