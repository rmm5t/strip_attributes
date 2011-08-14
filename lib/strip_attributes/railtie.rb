class StripAttributes::Railtie < Rails::Railtie
  initializer "strip_attributes.initialize" do |app|
    ::ActiveModel::Validations::ClassMethods.send(:include, StripAttributes)
  end
end
