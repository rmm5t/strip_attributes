begin
  require "minitest/matchers_vaccine"
rescue LoadError
  require "minitest/matchers"
end
require "test_helper"
require "strip_attributes/matchers"

class SampleMockRecord < Tableless
  attribute :stripped1
  attribute :stripped2
  attribute :stripped3
  attribute :unstripped1
  attribute :unstripped2
  attribute :unstripped3
  strip_attributes only: [:stripped1, :stripped2, :stripped3]

  attribute :collapsed
  attribute :uncollapsed
  strip_attributes only: [:collapsed], collapse_spaces: true
end

describe SampleMockRecord do
  include StripAttributes::Matchers

  subject { SampleMockRecord.new }

  if defined? Minitest::MatchersVaccine
    it "should strip strippable attributes" do
      must strip_attribute :stripped1
      must strip_attribute :stripped2
      must strip_attribute :stripped3
    end

    it "should not strip other attributes" do
      wont strip_attribute :unstripped1
      wont strip_attribute :unstripped2
      wont strip_attribute :unstripped3
    end

    it "should collapse collapsible attributes" do
      must strip_attribute(:collapsed).collapse_spaces
    end

    it "should not collapse other attributes" do
      wont strip_attribute(:uncollapsed).collapse_spaces
    end
  else
      must { strip_attribute :stripped1 }
      must { strip_attribute :stripped2 }
      must { strip_attribute :stripped3 }
      wont { strip_attribute :unstripped1 }
      wont { strip_attribute :unstripped2 }
      wont { strip_attribute :unstripped3 }

      must { strip_attribute(:collapsed).collapse_spaces }
      wont { strip_attribute(:uncollapsed).collapse_spaces }
  end

  it "should fail when testing for strip on an unstripped attribute" do
    begin
      assert_must strip_attribute(:unstripped1)
      assert false
    rescue
      assert true
    end
  end

  it "should fail when testing for no strip on a stripped attribute" do
    begin
      assert_wont strip_attribute(:stripped1)
      assert false
    rescue
      assert true
    end
  end

  it "should fail when testing for collapse on an uncollapsed attribute" do
    begin
      assert_must collapse_attribute(:uncollapsed)
      assert false
    rescue
      assert true
    end
  end

  it "should fail when testing for no collapse on a collapsed attribute" do
    begin
      assert_wont collapse_attribute(:collapsed)
      assert false
    rescue
      assert true
    end
  end
end
