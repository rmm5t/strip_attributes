require "minitest/autorun"
require "minitest/pride"
require "active_attr"
require "strip_attributes"

class Tableless
  include ActiveAttr::Model
  include ActiveModel::Validations::Callbacks
end
