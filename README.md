# StripAttributes [![Build Status](https://secure.travis-ci.org/rmm5t/strip_attributes.png)](http://travis-ci.org/rmm5t/strip_attributes)

StripAttributes is an ActiveModel extension that automatically strips all
attributes of leading and trailing whitespace before validation. If the
attribute is blank, it strips the value to `nil` by default.

It works by adding a before_validation hook to the record.  By default, all
attributes are stripped of whitespace, but `:only` and `:except`
options can be used to limit which attributes are stripped.  Both options accept
a single attribute (`:only => :field`) or arrays of attributes (`:except =>
[:field1, :field2, :field3]`).

## Installation

Include the gem in your Gemfile:

```ruby
gem "strip_attributes", "~> 1.2"
```

## Examples

### Default Behavior

```ruby
class DrunkPokerPlayer < ActiveRecord::Base
  strip_attributes
end
```

### Using `except`

```ruby
# all attributes will be stripped except :boxers
class SoberPokerPlayer < ActiveRecord::Base
  strip_attributes :except => :boxers
end
```

### Using `only`

```ruby
# only :shoe, :sock, and :glove attributes will be stripped
class ConservativePokerPlayer < ActiveRecord::Base
  strip_attributes :only => [:shoe, :sock, :glove]
end
```

### Using `allow_empty`

```ruby
# Empty attributes will not be converted to nil
class BrokePokerPlayer < ActiveRecord::Base
  strip_attributes :allow_empty => true
end
```

## Usage Patterns

### Other ORMs implementing `ActiveModel`

It also works on other ActiveModel classes, such as [Mongoid](http://mongoid.org/) documents:

```ruby
class User
  include Mongoid::Document
  strip_attributes :only => :email
end
```

### Using it with [`ActiveAttr`](https://github.com/cgriego/active_attr)

```ruby
class Person
  include ActiveAttr::Model
  include ActiveModel::Validations::Callbacks

  attribute :name
  attribute :email

  strip_attributes
end

```

## Testing

StripAttributes provides an RSpec/Shoulda-compatible matcher for easier
testing of attribute assignment. You can use this with
[RSpec](http://rspec.info/), [Shoulda](https://github.com/thoughtbot/shoulda),
or [Minitest-Matchers](https://github.com/zenspider/minitest-matchers).

### Setup `spec_helper.rb` or `test_helper.rb`

To initialize **RSpec**, add this to your `spec_helper.rb`:

```ruby
require "strip_attributes/matchers"
RSpec.configure do |config|
  config.include StripAttributes::Matchers
end
```

To initialize **Shoulda (with test-unit)**, add this to your `test_helper.rb`:

```ruby
require "strip_attributes/matchers"
class Test::Unit::TestCase
  extend StripAttributes::Matchers
end
```

To initialize **Minitest-Matchers**, add this to your `test_helper.rb`:

```ruby
require "strip_attributes/matchers"
class MiniTest::Spec
  include StripAttributes::Matchers
end
```

### Writing Tests

**Rspec**:

```ruby
describe User do
  it { should strip_attribute :name }
  it { should strip_attribute :email }
  it { should_not strip_attribute :password }
end
```

**Shoulda (with test-unit)**:

```ruby
class UserTest < ActiveSupport::TestCase
  should strip_attribute :name
  should strip_attribute :email
  should_not strip_attribute :password
end
```

**Minitest-Matchers**:

```ruby
describe User do
  subject { User.new }

  must { strip_attribute :name }
  must { strip_attribute :email }
  wont { strip_attribute :password }
end
```

## Support

Submit suggestions or feature requests as a GitHub Issue or Pull
Request (preferred). If you send a pull request, remember to update the
corresponding unit tests.  In fact, I prefer new features to be submitted in the
form of new unit tests.

## Credits

The idea was originally triggered by the information at the (now defunct) [Rails
Wiki](http://oldwiki.rubyonrails.org/rails/pages/HowToStripWhitespaceFromModelFields)
but was modified from the original to include more idiomatic ruby and rails
support.

## License

Copyright (c) 2007-2013 Ryan McGeary released under the [MIT
license](http://en.wikipedia.org/wiki/MIT_License)
