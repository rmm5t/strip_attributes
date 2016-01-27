# -*- encoding: utf-8 -*-
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "strip_attributes/version"

Gem::Specification.new do |spec|
  spec.name        = "strip_attributes"
  spec.version     = StripAttributes::VERSION
  spec.authors     = ["Ryan McGeary"]
  spec.email       = ["ryan@mcgeary.org"]
  spec.homepage    = "https://github.com/rmm5t/strip_attributes"
  spec.summary     = "Whitespace cleanup for ActiveModel attributes"
  spec.description = "StripAttributes automatically strips all ActiveRecord model attributes of leading and trailing whitespace before validation. If the attribute is blank, it strips the value to nil."
  spec.license     = "MIT"

  spec.files         = `git ls-files -- {app,bin,lib,test,spec}/* {LICENSE*,Rakefile,README*}`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec}/*`.split("\n")
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activemodel", ">= 3.0", "< 6.0"
  spec.add_development_dependency "active_attr", "~> 0.9"
  spec.add_development_dependency "minitest-matchers", "~> 1.2"
  spec.add_development_dependency "minitest", ">= 4.7", "< 6.0"
  spec.add_development_dependency "minitest-reporters", ">= 0.14.24"
  spec.add_development_dependency "rake", "~> 10.1.1" # 10.2 requires ruby 1.9
end
