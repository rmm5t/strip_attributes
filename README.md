# StripAttributes [![Gem Version](http://img.shields.io/gem/v/strip_attributes.svg)](https://rubygems.org/gems/strip_attributes) [![Build Status](https://secure.travis-ci.org/rmm5t/strip_attributes.svg)](http://travis-ci.org/rmm5t/strip_attributes) [![Code Climate](http://img.shields.io/codeclimate/github/rmm5t/strip_attributes.svg)](https://codeclimate.com/github/rmm5t/strip_attributes)

StripAttributes is an ActiveModel extension that automatically strips all
attributes of leading and trailing whitespace before validation. If the
attribute is blank, it strips the value to `nil` by default.

It works by adding a before_validation hook to the record.  By default, all
attributes are stripped of whitespace, but `:only` and `:except`
options can be used to limit which attributes are stripped.  Both options accept
a single attribute (`:only => :field`) or arrays of attributes (`:except =>
[:field1, :field2, :field3]`).

## How You Can Help

**If you like this project, please help. [Donate via Gittip][gittip] or [buy me a coffee with Bitcoin][bitcoin].**<br>
[![Gittip](http://img.shields.io/gittip/rmm5t.svg)][gittip]
[![Bitcoin](http://img.shields.io/badge/bitcoin-buy%20me%20a%20coffee-brightgreen.svg)][bitcoin]

**[Bitcoin][bitcoin]**: `1rmm5tv6f997JK5bLcGbRCZyVjZUPkQ2m`<br>
[![Bitcoin Donation][bitcoin-qr-small]][bitcoin-qr-big]

## Need Help?

**You can [book a session with me on Codementor][codementor].**<br>
[![Book a Codementor session](http://img.shields.io/badge/codementor-book%20a%20session-orange.svg)][codementor]

[gittip]: https://www.gittip.com/rmm5t/ "Donate to rmm5t for open source!"
[bitcoin]: https://blockchain.info/address/1rmm5tv6f997JK5bLcGbRCZyVjZUPkQ2m "Buy rmm5t a coffee for open source!"
[bitcoin-scheme]: bitcoin:1rmm5tv6f997JK5bLcGbRCZyVjZUPkQ2m?amount=0.01&label=Coffee%20to%20rmm5t%20for%20Open%20Source "Buy rmm5t a coffee for open source!"
[bitcoin-qr-small]: http://chart.apis.google.com/chart?cht=qr&chs=150x150&chl=bitcoin%3A1rmm5tv6f997JK5bLcGbRCZyVjZUPkQ2m%3Famount%3D0.01%26label%3DCoffee%2520to%2520rmm5t%2520for%2520Open%2520Source
[bitcoin-qr-big]: http://chart.apis.google.com/chart?cht=qr&chs=500x500&chl=bitcoin%3A1rmm5tv6f997JK5bLcGbRCZyVjZUPkQ2m%3Famount%3D0.01%26label%3DCoffee%2520to%2520rmm5t%2520for%2520Open%2520Source
[codementor]: https://www.codementor.io/rmm5t "Book a session with rmm5t on Codementor!"

## Installation

Include the gem in your Gemfile:

```ruby
gem "strip_attributes"
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

### Using `collapse_spaces`

```ruby
# Sequential spaces in attributes will be collapsed to one space
class EloquentPokerPlayer < ActiveRecord::Base
  strip_attributes :collapse_spaces => true
end
```

### Using `regex`

```ruby
class User < ActiveRecord::Base
  # Strip off characters defined by RegEx
  strip_attributes :only => [:first_name, :last_name], :regex => /[^[:alpha:]\s]/
  # Strip off non-integers
  strip_attributes :only => [:phone], :regex => /[^0-9]/
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
  it { should strip_attribute(:name).collapse_spaces }
  it { should strip_attribute :email }
  it { should_not strip_attribute :password }
end
```

**Shoulda (with test-unit)**:

```ruby
class UserTest < ActiveSupport::TestCase
  should strip_attribute(:name).collapse_spaces
  should strip_attribute :email
  should_not strip_attribute :password
end
```

**Minitest-Matchers**:

```ruby
describe User do
  subject { User.new }

  must { strip_attribute(:name).collapse_spaces }
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
