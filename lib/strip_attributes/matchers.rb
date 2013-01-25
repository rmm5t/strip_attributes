module StripAttributes
  module Matchers

    def strip_attribute(attribute)
      StripAttributeMatcher.new(attribute)
    end

    class StripAttributeMatcher
      def initialize(attribute)
        @attribute = attribute
      end

      def matches?(subject)
        subject.send("#{@attribute}=", " string ")
        subject.valid?
        subject.send(@attribute) == "string"
      end

      def failure_message
        "Expected whitespace to be stripped from `#{@attribute}`, but it was not"
      end

      def negative_failure_message
        "Expected whitespace to remain on `#{@attribute}`, but it was stripped"
      end

      def description
        "strip whitespace from ##{@attribute}"
      end
    end

  end
end
