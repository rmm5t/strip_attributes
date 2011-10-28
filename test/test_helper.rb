require "test/unit"
require "active_record"
require "strip_attributes"

# Tableless AR borrowed from
# http://stackoverflow.com/questions/937429/activerecordbase-without-table
class Tableless < ActiveRecord::Base
  def self.columns()
    @columns ||= []
  end

  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type, null)
  end

  def save(validate = true)
    validate ? valid? : true
  end
end
