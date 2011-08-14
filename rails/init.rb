require "strip_attributes"
::ActiveModel::Validations::ClassMethods.send(:include, StripAttributes)
