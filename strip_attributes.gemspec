# -*- encoding: utf-8 -*-
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "strip_attributes/version"

Gem::Specification.new do |gem|
  gem.name        = "strip_attributes"
  gem.version     = StripAttributes::VERSION
  gem.authors     = ["Ryan McGeary"]
  gem.email       = ["ryan@mcgeary.org"]
  gem.homepage    = "https://github.com/rmm5t/strip_attributes"
  gem.summary     = "Whitespace cleanup for ActiveModel attributes"
  gem.description = "StripAttributes automatically strips all ActiveRecord model attributes of leading and trailing whitespace before validation. If the attribute is blank, it strips the value to nil."

  gem.files         = Dir["{lib,test}/**/*", "README*"]
  gem.test_files    = Dir["{test}/**/*"]
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "activemodel", "~> 3.0"
  gem.add_development_dependency "activerecord", "~> 3.0"
  gem.add_development_dependency "rake", "~> 10.0"
end
