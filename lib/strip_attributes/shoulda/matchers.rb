module StripAttributes
  module Shoulda
    module Matchers

      def strip_attributes(*attributes)
        StripAttributesMatcher.new(attributes)
      end

      class StripAttributesMatcher
        def initialize(attributes)
          @attributes = attributes
        end

        def matches?(subject)
          @attributes.each { |attribute| subject.send("#{attribute}=", " string ") }
          subject.valid?
          @attributes.all? { |attribute| subject.send(attribute) == "string" }
        end

        def failure_message
          "Expected stripped whitespaces attributes: #{attributes_string},
          but some of them not stripped still"
        end

        def negative_failure_message
          "Expected not stripped whitespaces attributes: #{attributes_string},
          but some of them stripped still"
        end

        def description
          "strip whitespaces from attributes: #{attributes_string}"
        end
        
        def attributes_string
          @attributes.join(', ')
        end
      end
      
    end  
  end
end
