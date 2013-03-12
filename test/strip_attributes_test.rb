require "test_helper"

module MockAttributes
  def self.included(base)
    base.attribute :foo
    base.attribute :bar
    base.attribute :biz
    base.attribute :baz
    base.attribute :bang
    base.attribute :foz
  end
end

class StripAllMockRecord < Tableless
  include MockAttributes
  strip_attributes
end

class StripOnlyOneMockRecord < Tableless
  include MockAttributes
  strip_attributes :only => :foo
end

class StripOnlyThreeMockRecord < Tableless
  include MockAttributes
  strip_attributes :only => [:foo, :bar, :biz]
end

class StripExceptOneMockRecord < Tableless
  include MockAttributes
  strip_attributes :except => :foo
end

class StripExceptThreeMockRecord < Tableless
  include MockAttributes
  strip_attributes :except => [:foo, :bar, :biz]
end

class StripAllowEmpty < Tableless
  include MockAttributes
  strip_attributes :allow_empty => true
end

class CollapseDuplicateSpaces < Tableless
  include MockAttributes
  strip_attributes :collapse_spaces => true
end

class StripAttributesTest < MiniTest::Unit::TestCase
  def setup
    @init_params = { :foo => "\tfoo", :bar => "bar \t ", :biz => "\tbiz ", :baz => "", :bang => " ", :foz => " foz  foz" }
  end

  def test_should_exist
    assert Object.const_defined?(:StripAttributes)
  end

  def test_should_strip_all_fields
    record = StripAllMockRecord.new(@init_params)
    record.valid?
    assert_equal "foo",      record.foo
    assert_equal "bar",      record.bar
    assert_equal "biz",      record.biz
    assert_equal "foz  foz", record.foz
    assert_nil record.baz
    assert_nil record.bang
  end

  def test_should_strip_only_one_field
    record = StripOnlyOneMockRecord.new(@init_params)
    record.valid?
    assert_equal "foo",      record.foo
    assert_equal "bar \t ",  record.bar
    assert_equal "\tbiz ",   record.biz
    assert_equal " foz  foz", record.foz
    assert_equal "",         record.baz
    assert_equal " ",        record.bang
  end

  def test_should_strip_only_three_fields
    record = StripOnlyThreeMockRecord.new(@init_params)
    record.valid?
    assert_equal "foo",      record.foo
    assert_equal "bar",      record.bar
    assert_equal "biz",      record.biz
    assert_equal " foz  foz", record.foz
    assert_equal "",         record.baz
    assert_equal " ",        record.bang
  end

  def test_should_strip_all_except_one_field
    record = StripExceptOneMockRecord.new(@init_params)
    record.valid?
    assert_equal "\tfoo",    record.foo
    assert_equal "bar",      record.bar
    assert_equal "biz",      record.biz
    assert_equal "foz  foz", record.foz
    assert_nil record.baz
    assert_nil record.bang
  end

  def test_should_strip_all_except_three_fields
    record = StripExceptThreeMockRecord.new(@init_params)
    record.valid?
    assert_equal "\tfoo",    record.foo
    assert_equal "bar \t ",  record.bar
    assert_equal "\tbiz ",   record.biz
    assert_equal "foz  foz", record.foz
    assert_nil record.baz
    assert_nil record.bang
  end

  def test_should_strip_and_allow_empty
    record = StripAllowEmpty.new(@init_params)
    record.valid?
    assert_equal "foo",      record.foo
    assert_equal "bar",      record.bar
    assert_equal "biz",      record.biz
    assert_equal "foz  foz", record.foz
    assert_equal "",         record.baz
    assert_equal "",         record.bang
  end

  def test_should_collapse_duplicate_spaces
    record = CollapseDuplicateSpaces.new(@init_params)
    record.valid?
    assert_equal "foo",     record.foo
    assert_equal "bar",     record.bar
    assert_equal "biz",     record.biz
    assert_equal "foz foz", record.foz
    assert_equal nil,       record.baz
    assert_equal nil,       record.bang
  end

  def test_should_strip_and_allow_empty_always
    record = StripAllowEmpty.new(@init_params)
    record.valid?
    record.assign_attributes(@init_params)
    record.valid?
    assert_equal "foo",      record.foo
    assert_equal "bar",      record.bar
    assert_equal "biz",      record.biz
    assert_equal "foz  foz", record.foz
    assert_equal "",         record.baz
    assert_equal "",         record.bang
  end
end
