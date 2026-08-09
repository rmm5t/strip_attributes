require "minitest/autorun"
require "minitest/reporters"
if ENV["CI"] == "true"
  Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new
else
  Minitest::Reporters.use! Minitest::Reporters::ProgressReporter.new
end

require "active_attr"
require "strip_attributes"

class Tableless
  include ActiveAttr::BasicModel
  include ActiveAttr::TypecastedAttributes
  include ActiveAttr::Serialization

  include ActiveModel::Validations::Callbacks
  
  # Simple mock of save callbacks for testing
  extend ActiveModel::Callbacks
  define_model_callbacks :save
  
  # Mock save method that respects validate: false option
  def save(options = {})
    if options[:validate] == false
      # When validate: false, skip validation but still run save callbacks
      run_callbacks :save
    else
      # Normal save: run validation callbacks then save callbacks
      run_callbacks :validation
      run_callbacks :save
    end
    true
  end
end

# Avoid annoying deprecation warning
I18n.enforce_available_locales = true

# Remove this after we drop support for Rails 3.2 and Minitest 4.x
Minitest::Test = Minitest::Unit::TestCase unless defined?(Minitest::Test)
