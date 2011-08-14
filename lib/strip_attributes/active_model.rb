require "strip_attributes"
require "active_model"

module ActiveModel::Validations::HelperMethods
  include StripAttributes
end
