require "shoulda/context"

module StripAttributes
  module Shoulda
    module Macros
      def should_strip_attributes(*attributes)
        attributes.each do |attribute|
          attribute = attribute.to_sym
          should "strip whitespace from #{attribute}" do
            subject.send("#{attribute}=", " string ")
            subject.valid?
            assert_equal "string", subject.send(attribute)
          end
        end
      end

      def should_not_strip_attributes(*attributes)
        attributes.each do |attribute|
          attribute = attribute.to_sym
          should "not strip whitespace from #{attribute}" do
            subject.send("#{attribute}=", " string ")
            subject.valid?
            assert_equal " string ", subject.send(attribute)
          end
        end
      end
    end
  end
end
