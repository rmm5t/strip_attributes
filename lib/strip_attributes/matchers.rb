module StripAttributes
  module Matchers

    # Whitespace is stripped from the beginning and end of the attribute
    #
    # RSpec Examples:
    #
    #   it { is_expected.to strip_attribute(:first_name) }
    #   it { is_expected.to strip_attributes(:first_name, :last_name) }
    #   it { is_expected.not_to strip_attribute(:password) }
    #   it { is_expected.not_to strip_attributes(:password, :encrypted_password) }
    #
    # Minitest Matchers Examples:
    #
    #   must { strip_attribute :first_name }
    #   must { strip_attributes(:first_name, :last_name) }
    #   wont { strip_attribute :password }
    #   wont { strip_attributes(:password, :encrypted_password) }
    def strip_attribute(*attributes)
      StripAttributeMatcher.new(attributes)
    end

    alias_method :strip_attributes, :strip_attribute

    class StripAttributeMatcher
      def initialize(attributes)
        @attributes = attributes
        @options = {}
      end

      def matches?(subject)
        @attributes.all? do |attribute|
          @attribute = attribute
          subject.send("#{@attribute}=", " string ")
          subject.valid?
          subject.send(@attribute) == "string" and collapse_spaces?(subject)
        end
      end

      def collapse_spaces
        @options[:collapse_spaces] = true
        self
      end

      def failure_message # RSpec 3.x
        "Expected whitespace to be #{expectation} from ##{@attribute}, but it was not"
      end
      alias_method :failure_message_for_should, :failure_message # RSpec 1.2, 2.x, and minitest-matchers

      def failure_message_when_negated # RSpec 3.x
        "Expected whitespace to remain on ##{@attribute}, but it was #{expectation}"
      end
      alias_method :failure_message_for_should_not, :failure_message_when_negated # RSpec 1.2, 2.x, and minitest-matchers
      alias_method :negative_failure_message,       :failure_message_when_negated # RSpec 1.1

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
        expectation
      end
    end
  end
end
