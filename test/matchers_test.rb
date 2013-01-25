require "minitest/matchers"
require "test_helper"
require "strip_attributes/shoulda/matchers"

class SampleMockRecord < Tableless
  attributes :stripped1, :stripped2, :stripped3
  attributes :unstripped1, :unstripped2, :unstripped3

  strip_attributes :only => [:stripped1, :stripped2, :stripped3]
end

describe SampleMockRecord do
  include StripAttributes::Shoulda::Matchers

  subject { SampleMockRecord.new }

  must { strip_attributes(:stripped1, :stripped2, :stripped3) }
  wont { strip_attributes(:unstripped1, :unstripped2, :unstripped3) }
end
