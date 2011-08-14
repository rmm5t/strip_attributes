require "strip_attributes"

::ActiveModel::Validations::HelperMethods.send(:include, StripAttributes)

