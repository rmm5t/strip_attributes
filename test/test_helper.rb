require "minitest/autorun"
require "minitest/pride"
require "active_record"
require "active_support/core_ext/hash/indifferent_access"
require "strip_attributes"

# Tableless ActiveModel with some parts borrowed from both
# http://railscasts.com/episodes/219-active-model and ActiveRecord's
# implementation.
class Tableless
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def attributes
    attrs = HashWithIndifferentAccess.new
    self.class.attribute_names.each { |name| attrs[name] = self[name] }
    attrs
  end

  def [](name)
    send name
  end

  def []=(name, value)
    send "#{name}=", value
  end

  def self.attribute_names
    @attribute_names ||= []
  end

  def self.attributes(*names)
    attr_accessor *names
    attribute_names.concat names
  end
end
