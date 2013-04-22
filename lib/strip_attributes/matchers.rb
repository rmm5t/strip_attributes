module StripAttributes
  module Matchers

    # Whitespace is stripped from the beginning and end of the attribute
    #
    # RSpec Examples:
    #
    #   it { should strip_attribute(:first_name) }
    #   it { should_not strip_attribute(:password) }
    #
    # Minitest Matchers Examples:
    #
    #   must { strip_attribute :first_name }
    #   wont { strip_attribute :password }
    def strip_attribute(attribute)
      StripAttributeMatcher.new(attribute)
    end

    class StripAttributeMatcher
      def initialize(attribute)
        @attribute = attribute
        @options = {}
      end

      def matches?(subject)
        subject.send("#{@attribute}=", " string ")
        subject.valid?
        subject.send(@attribute) == "string" and collapse_spaces?(subject)
      end

      def collapse_spaces
        @options[:collapse_spaces] = true
        self
      end

      def failure_message
        "Expected whitespace to be #{expectation} from ##{@attribute}, but it was not"
      end

      def negative_failure_message
        "Expected whitespace to remain on ##{@attribute}, but it was #{expectation}"
      end

      def description
        "#{expectation(false)} whitespace from ##{@attribute}"
      end

      private

      def collapse_spaces?(subject)
        return true if !@options[:collapse_spaces]

        subject.send("#{@attribute}=", " string    string ")
        subject.valid?
        subject.send(@attribute) == "string string"
      end

      def expectation(past = true)
        expectation = past ? "stripped" : "strip"
        expectation += past ? " and collapsed" : " and collapse" if @options[:collapse_spaces]
      end
    end
  end
end
