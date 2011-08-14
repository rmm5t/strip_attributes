class StripAttributes::Railtie < Rails::Railtie
  initializer "strip_attributes.initialize" do |app|
    require "strip_attributes/active_model"
  end
end
