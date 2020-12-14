# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "webvtt/version"

Gem::Specification.new do |s|
  s.name        = "webvtt"
  s.version     = Webvtt::VERSION
  s.authors     = ["Jason Ronallo"]
  s.email       = ["jronallo@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{WEBVTT file parser in Ruby}
  s.description = %q{WEBVTT file parser in Ruby}

  s.rubyforge_project = "webvtt"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_development_dependency "test-unit", [">= 2.5.0"]
  s.add_development_dependency "guard-test", [">= 0.5.0"]
  s.add_development_dependency "byebug"
end
