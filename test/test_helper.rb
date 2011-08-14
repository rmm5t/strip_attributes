require "test/unit"
require "active_record"
require "strip_attributes/active_model"

class ActiveRecord::Base
  alias_method :save, :valid?
  def self.columns()
    @columns ||= []
  end

  def self.column(name, sql_type = nil, default = nil, null = true)
    @columns ||= []
    @columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type, null)
  end
end
