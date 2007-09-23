module StripAttributes
  # Strips whitespace from model fields and converts blank values to nil.
  def strip_attributes!(options = nil)
    before_validation do |record|
      attr_names = record.attributes(options).keys
      attr_names.each do |attr_name|
        s = record[attr_name]
        if s.respond_to?(:strip)
          record[attr_name] = (s.blank?) ? nil : s.strip
        end
      end
    end
  end
end
