require 'shoulda/active_record'

module StripAttributes
  module Macros
    def should_strip_attributes(*attributes)
      klass = respond_to?(:described_type) ? described_type : model_class
      attributes.each do |attribute|
        attribute = attribute.to_sym
        should "strip whitespace from #{attribute}" do
          object = get_instance_of(klass)
          object.send("#{attribute}=", " string ")
          object.valid?
          assert_equal "string", object.send(attribute)
        end
      end
    end

    def should_not_strip_attributes(*attributes)
      klass = respond_to?(:described_type) ? described_type : model_class
      attributes.each do |attribute|
        attribute = attribute.to_sym
        should "not strip whitespace from #{attribute}" do
          object = get_instance_of(klass)
          object.send("#{attribute}=", " string ")
          object.valid?
          assert_equal " string ", object.send(attribute)
        end
      end
    end
  end
end

class Test::Unit::TestCase
  extend StripAttributes::Macros
end
