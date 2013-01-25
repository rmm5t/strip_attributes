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

  it "should fail when testing for strip on an unstripped attribute" do
    begin
      assert_must strip_attributes(:unstripped1)
      assert false
    rescue
      assert true
    end
  end

  it "should fail when testing for no strip on a stripped attribute" do
    begin
      assert_wont strip_attributes(:stripped1)
      assert false
    rescue
      assert true
    end
  end
end
