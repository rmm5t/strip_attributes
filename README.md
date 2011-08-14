# StripAttributes

StripAttributes is a Rails plugin that automatically strips all ActiveRecord
model attributes of leading and trailing whitespace before validation. If the
attribute is blank, it strips the value to `nil`.

It works by adding a before_validation hook to the record.  By default, all
attributes are stripped of whitespace, but `:only`> and `:except`
options can be used to limit which attributes are stripped.  Both options accept
a single attribute (`:only => :field`) or arrays of attributes (`:except =>
[:field1, :field2, :field3]`).

## Examples

    class DrunkPokerPlayer < ActiveRecord::Base
      strip_attributes!
    end

    class SoberPokerPlayer < ActiveRecord::Base
      strip_attributes! :except => :boxers
    end

    class ConservativePokerPlayer < ActiveRecord::Base
      strip_attributes! :only => [:shoe, :sock, :glove]
    end

## Installation

StripAttributes is distributed as a gem. It was once a plugin, but that is now
discouraged.

Include the gem in your Gemfile:

    gem "strip_attributes", "~> 0.9"

Or, if you don't use Bundler (though you probably should, even in Rails 2), with
config.gem

    # In config/environment.rb
    Rails::Initializer.run do |config|
      # ...
      config.gem "strip_attributes", :version => "~> 0.9"
      # ...
    end

Note: For Rails 2.x, be sure to use the `~> 0.9` version of
StripAttributes, because StripAttributes ties directly into
ActiveRecord. Later versions (`> 1.0`) are geared towards Rails 3 and
ActiveModel.

## Usage Outside of Rails

If you want to use this outside of Rails, extend StripAttributes in your
ActiveRecord model after putting `strip_attributes` in your `$LOAD_PATH`:

    require "strip_attributes"
    class SomeModel < ActiveRecord::Base
      extend StripAttributes
      strip_attributes!
    end

## Testing

StripAttributes provides shoulda-compatible macros for easier testing of
attribute assignment.

To initialize, extend `StripAttributes::Shoulda::Macros` in your
`test_helper.rb`:

    require "strip_attributes/shoulda"
    class Test::Unit::TestCase
      extend StripAttributes::Shoulda::Macros
    end

And in your unit tests:

    class UserTest < ActiveSupport::TestCase
      should_strip_attributes :name, :email
      should_not_strip_attributes :password
    end

## Support

Feel free to submit suggestions or feature requests as a GitHub Issue or Pull
Request (preferred). If you send a pull request, remember to update the
corresponding unit tests.  In fact, I prefer new features to be submitted in the
form of new unit tests.

## Credits

The idea was originally triggered by the information at the (now defunct) [Rails
Wiki](http://wiki.rubyonrails.org/rails/pages/HowToStripWhitespaceFromModelFields)
but was modified from the original to include more idiomatic ruby and rails
support.

## License

Copyright (c) 2007-2011 Ryan McGeary released under the [MIT
license](http://en.wikipedia.org/wiki/MIT_License)
