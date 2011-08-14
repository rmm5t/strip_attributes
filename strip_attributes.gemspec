# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "strip_attributes"

Gem::Specification.new do |s|
  s.name        = "strip_attributes"
  s.version     = StripAttributes::VERSION
  s.authors     = ["Ryan McGeary"]
  s.email       = ["ryan@mcgeary.org"]
  s.homepage    = "https://github.com/rmm5t/strip_attributes"
  s.summary     = "Whitespace cleanup for ActiveRecord attributes"
  s.description = "StripAttributes automatically strips all ActiveRecord model attributes of leading and trailing whitespace before validation. If the attribute is blank, it strips the value to nil."

  s.rubyforge_project = "strip_attributes"

  s.files         = Dir["{lib,rails,test}/**/*"]
  s.test_files    = Dir["{test}/**/*"]
  s.require_paths = ["lib"]

  s.add_runtime_dependency "activemodel", "~> 3.0"
  s.add_development_dependency "activerecord", "~> 3.0"
end
