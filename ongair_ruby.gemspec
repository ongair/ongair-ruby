# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ongair_ruby/version'

Gem::Specification.new do |spec|
  spec.name          = "ongair_ruby"
  spec.version       = OngairRuby::VERSION
  spec.authors       = ["Ongair Limited"]
  spec.email         = ["hello@ongair.im"]
  spec.summary       = %q{Ruby gem for Ongair.}
  spec.description   = %q{Lets you use the Ongair API to interact with Messaging services like WhatsApp, WeChat and so on.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "simplecov"
end
