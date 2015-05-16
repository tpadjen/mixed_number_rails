# MixedNumber

Store mixed numbers in an ActiveRecord model seamlessly with built-in validation.

## Installation

Add this line to your application's Gemfile:

    gem 'mixed_number_rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mixed_number_rails

## Usage
**rails_mixed_number** is based on my general purpose [mixed_number](https://github.com/tpadjen/mixed_number) ruby gem. Go there for examples on using MixedNumber objects.

### Hooking up with Rails
1. Create a model with a decimal attribute
	```sh
	? rails g model Item amount:decimal
	```
2. Open the model file you just generated and add `mixed_number_attribute` with the name of your attribute
	```ruby
	class Item < ActiveRecord::Base
		mixed_number_attribute :amount
	end
	```
3. Your attribute will now be a mixed number, with validation.


## Contributing

1. Fork it ( https://github.com/tpadjen/mixed_number_rails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
