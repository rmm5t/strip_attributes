require "test_helper"

module MockAttributes
  def self.included(base)
    base.attribute :foo
    base.attribute :bar
    base.attribute :biz
    base.attribute :baz
    base.attribute :bang
    base.attribute :foz
    base.attribute :fiz
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

class RemoveNewLines < Tableless
  include MockAttributes
  strip_attributes :remove_new_lines => true
end

class RemoveNewLinesAndDuplicateSpaces < Tableless
  include MockAttributes
  strip_attributes :remove_new_lines => true, :collapse_spaces => true
end

class CoexistWithOtherValidations < Tableless
  attribute :number, :type => Integer

  strip_attributes
  validates :number, {
    :numericality => { :only_integer => true,  :greater_than_or_equal_to => 1000 },
    :allow_blank => true
  }
end

class StripRegexMockRecord < Tableless
  include MockAttributes
  strip_attributes :regex => /[\^\%&\*]/
end

class StripAttributesTest < Minitest::Test
  def setup
    @init_params = { :foo => "\tfoo", :bar => "bar \t ", :biz => "\tbiz ", :baz => "", :bang => " ", :foz => " foz  foz", :fiz => "fiz \n  fiz" }
  end

  def test_should_exist
    assert Object.const_defined?(:StripAttributes)
  end

  def test_should_strip_all_fields
    record = StripAllMockRecord.new(@init_params)
    record.valid?
    assert_equal "foo",         record.foo
    assert_equal "bar",         record.bar
    assert_equal "biz",         record.biz
    assert_equal "foz  foz",    record.foz
    assert_equal "fiz \n  fiz", record.fiz
    assert_nil record.baz
    assert_nil record.bang
  end

  def test_should_strip_only_one_field
    record = StripOnlyOneMockRecord.new(@init_params)
    record.valid?
    assert_equal "foo",         record.foo
    assert_equal "bar \t ",     record.bar
    assert_equal "\tbiz ",      record.biz
    assert_equal " foz  foz",   record.foz
    assert_equal "fiz \n  fiz", record.fiz
    assert_equal "",            record.baz
    assert_equal " ",           record.bang
  end

  def test_should_strip_only_three_fields
    record = StripOnlyThreeMockRecord.new(@init_params)
    record.valid?
    assert_equal "foo",         record.foo
    assert_equal "bar",         record.bar
    assert_equal "biz",         record.biz
    assert_equal " foz  foz",   record.foz
    assert_equal "fiz \n  fiz", record.fiz
    assert_equal "",            record.baz
    assert_equal " ",           record.bang
  end

  def test_should_strip_all_except_one_field
    record = StripExceptOneMockRecord.new(@init_params)
    record.valid?
    assert_equal "\tfoo",       record.foo
    assert_equal "bar",         record.bar
    assert_equal "biz",         record.biz
    assert_equal "foz  foz",    record.foz
    assert_equal "fiz \n  fiz", record.fiz
    assert_nil record.baz
    assert_nil record.bang
  end

  def test_should_strip_all_except_three_fields
    record = StripExceptThreeMockRecord.new(@init_params)
    record.valid?
    assert_equal "\tfoo",       record.foo
    assert_equal "bar \t ",     record.bar
    assert_equal "\tbiz ",      record.biz
    assert_equal "foz  foz",    record.foz
    assert_equal "fiz \n  fiz", record.fiz
    assert_nil record.baz
    assert_nil record.bang
  end

  def test_should_strip_and_allow_empty
    record = StripAllowEmpty.new(@init_params)
    record.valid?
    assert_equal "foo",         record.foo
    assert_equal "bar",         record.bar
    assert_equal "biz",         record.biz
    assert_equal "foz  foz",    record.foz
    assert_equal "fiz \n  fiz", record.fiz
    assert_equal "",            record.baz
    assert_equal "",            record.bang
  end

  def test_should_collapse_duplicate_spaces
    record = CollapseDuplicateSpaces.new(@init_params)
    record.valid?
    assert_equal "foo",        record.foo
    assert_equal "bar",        record.bar
    assert_equal "biz",        record.biz
    assert_equal "foz foz",    record.foz
    assert_equal "fiz \n fiz", record.fiz
    assert_equal nil,          record.baz
    assert_equal nil,          record.bang
  end

  def test_should_remove_newlines
    record = RemoveNewLines.new(@init_params)
    record.valid?
    assert_equal "foo",        record.foo
    assert_equal "bar",        record.bar
    assert_equal "biz",        record.biz
    assert_equal "foz  foz",   record.foz
    assert_equal "fiz    fiz", record.fiz
    assert_equal nil,          record.baz
    assert_equal nil,          record.bang
  end

  def test_should_remove_newlines_and_duplicate_spaces
    record = RemoveNewLinesAndDuplicateSpaces.new(@init_params)
    record.valid?
    assert_equal "foo",     record.foo
    assert_equal "bar",     record.bar
    assert_equal "biz",     record.biz
    assert_equal "foz foz", record.foz
    assert_equal "fiz fiz", record.fiz
    assert_equal nil,       record.baz
    assert_equal nil,       record.bang
  end

  def test_should_strip_and_allow_empty_always
    record = StripAllowEmpty.new(@init_params)
    record.valid?
    record.assign_attributes(@init_params)
    record.valid?
    assert_equal "foo",         record.foo
    assert_equal "bar",         record.bar
    assert_equal "biz",         record.biz
    assert_equal "foz  foz",    record.foz
    assert_equal "fiz \n  fiz", record.fiz
    assert_equal "",            record.baz
    assert_equal "",            record.bang
  end

  def test_should_coexist_with_other_validations
    record = CoexistWithOtherValidations.new
    record.number = 1000.1
    assert !record.valid?, "Expected record to be invalid"
    assert record.errors.include?(:number), "Expected record to have an error on :number"

    record = CoexistWithOtherValidations.new(:number => " 1000.2 ")
    assert !record.valid?, "Expected record to be invalid"
    assert record.errors.include?(:number), "Expected record to have an error on :number"

    # record = CoexistWithOtherValidations.new(:number => " 1000 ")
    # assert record.valid?, "Expected record to be valid, but got #{record.errors.full_messages}"
    # assert !record.errors.include?(:number), "Expected record to have no errors on :number"
  end

  def test_should_strip_regex
    record = StripRegexMockRecord.new
    record.assign_attributes(@init_params.merge(:foo => "^%&*abc  "))
    record.valid?
    assert_equal "abc",        record.foo
    assert_equal "bar",        record.bar
  end

  def test_should_strip_unicode
    # This feature only works if multi-byte characters are supported by Ruby
    return if "\u0020" != " "
    # U200A - HAIR SPACE
    # U200B - ZERO WIDTH SPACE
    record = StripOnlyOneMockRecord.new({:foo => "\u200A\u200B foo\u200A\u200B "})
    record.valid?
    assert_equal "foo",      record.foo
  end

  class ClassMethodsTest < Minitest::Test
    def test_should_strip_whitespace
      assert_equal nil, StripAttributes.strip("")
      assert_equal nil, StripAttributes.strip(" \t ")
      assert_equal "thirty six", StripAttributes.strip(" thirty six \t \n")
    end

    def test_should_allow_empty
      assert_equal "", StripAttributes.strip("", :allow_empty => true)
      assert_equal "", StripAttributes.strip(" \t ", :allow_empty => true)
    end

    def test_should_collapse_spaces
      assert_equal "1 2 3", StripAttributes.strip(" 1   2   3\t ", :collapse_spaces => true)
    end

    def test_should_remove_new_lines
      assert_equal "1 2", StripAttributes.strip("1\n2", :remove_new_lines => true)
    end

    def test_should_strip_regex
      assert_equal "abc", StripAttributes.strip("^%&*abc  ^  ", :regex => /[\^\%&\*]/)
    end

    def test_should_strip_unicode
      # This feature only works if multi-byte characters are supported by Ruby
      return if "\u0020" != " "
      # U200A - HAIR SPACE
      # U200B - ZERO WIDTH SPACE
      assert_equal "foo", StripAttributes.strip("\u200A\u200B foo\u200A\u200B ")
    end
  end
end
