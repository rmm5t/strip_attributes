require "#{File.dirname(__FILE__)}/test_helper"

module MockAttributes
  def self.included(base)
    base.column :foo,  :string
    base.column :bar,  :string
    base.column :biz,  :string
    base.column :baz,  :string
    base.column :bang, :string
  end
end

class StripAllMockRecord < ActiveRecord::Base
  include MockAttributes
  strip_attributes!
end

class StripOnlyOneMockRecord < ActiveRecord::Base
  include MockAttributes
  strip_attributes! :only => :foo
end

class StripOnlyThreeMockRecord < ActiveRecord::Base
  include MockAttributes
  strip_attributes! :only => [:foo, :bar, :biz]
end

class StripExceptOneMockRecord < ActiveRecord::Base
  include MockAttributes
  strip_attributes! :except => :foo
end

class StripExceptThreeMockRecord < ActiveRecord::Base
  include MockAttributes
  strip_attributes! :except => [:foo, :bar, :biz]
end

class StripAttributesTest < Test::Unit::TestCase
  def setup
    @init_params = { :foo => "\tfoo", :bar => "bar \t ", :biz => "\tbiz ", :baz => "", :bang => " " }
  end

  def test_should_exist
    assert Object.const_defined?(:StripAttributes)
  end

  def test_should_strip_all_fields
    record = StripAllMockRecord.new(@init_params)
    record.valid?
    assert_equal "foo", record.foo
    assert_equal "bar", record.bar
    assert_equal "biz", record.biz
    assert_nil record.baz
    assert_nil record.bang
  end

  def test_should_strip_only_one_field
    record = StripOnlyOneMockRecord.new(@init_params)
    record.valid?
    assert_equal "foo",     record.foo
    assert_equal "bar \t ", record.bar
    assert_equal "\tbiz ",  record.biz
    assert_equal "",        record.baz
    assert_equal " ",       record.bang
  end

  def test_should_strip_only_three_fields
    record = StripOnlyThreeMockRecord.new(@init_params)
    record.valid?
    assert_equal "foo", record.foo
    assert_equal "bar", record.bar
    assert_equal "biz", record.biz
    assert_equal "",    record.baz
    assert_equal " ",   record.bang
  end

  def test_should_strip_all_except_one_field
    record = StripExceptOneMockRecord.new(@init_params)
    record.valid?
    assert_equal "\tfoo", record.foo
    assert_equal "bar",   record.bar
    assert_equal "biz",   record.biz
    assert_nil record.baz
    assert_nil record.bang
  end

  def test_should_strip_all_except_three_fields
    record = StripExceptThreeMockRecord.new(@init_params)
    record.valid?
    assert_equal "\tfoo",   record.foo
    assert_equal "bar \t ", record.bar
    assert_equal "\tbiz ",  record.biz
    assert_nil record.baz
    assert_nil record.bang
  end
end
