require "active_model"

module ActiveModel::Validations::HelperMethods
  # Strips whitespace from model fields and converts blank values to nil.
  def strip_attributes(options = nil)
    before_validation do |record|
      allow_empty = options.delete(:allow_empty) if options

      attributes = StripAttributes.narrow(record.attributes, options)
      attributes.each do |attr, value|
        if value.respond_to?(:strip)
          record[attr] = (value.blank? && !allow_empty) ? nil : value.strip
        end
      end
    end
  end

  # <b>DEPRECATED:</b> Please use <tt>strip_attributes</tt> (non-bang method)
  # instead.
  def strip_attributes!(options = nil)
    warn "[DEPRECATION] `strip_attributes!` is deprecated.  Please use `strip_attributes` (non-bang method) instead."
    strip_attributes(options)
  end
end

module StripAttributes
  # Necessary because Rails has removed the narrowing of attributes using :only
  # and :except on Base#attributes
  def self.narrow(attributes, options)
    if options.nil? || options.empty?
      attributes
    else
      if except = options[:except]
        except = Array(except).collect { |attribute| attribute.to_s }
        attributes.except(*except)
      elsif only = options[:only]
        only = Array(only).collect { |attribute| attribute.to_s }
        attributes.slice(*only)
      else
        raise ArgumentError, "Options does not specify :except or :only (#{options.keys.inspect})"
      end
    end
  end
end
