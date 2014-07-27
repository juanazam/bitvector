# BitVector

Small gem to manage integer fields as bit vectors of size 32.

## Installation

Add this line to your application's Gemfile:

    gem 'bitvector'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bitvector

## Usage

### Rails Example:

You want to represent your data as a bit vector, for example, lets say you want to represent days of the
week and store them as a bit vector (assuming days_of_week is an int attribute):

```
class Schedule < ActiveRecord::Base
  serialize days_of_week, BitVector::BitVector
end

schedule = Schedule.new
vector = schedule.days_of_week # => This is a BitVector!

# Mark monday as true
vector[0] = 1

puts vector # => '00000000000000000000000000000001'

```

If you save a schedule instance, the value will be persisted as integer.

```
schedule.days_of_week = BitVector::BitVector.new(1).
schedule.save # => days_of_week fields is serialized as 1 in database.
```

## Contributing

1. Fork it ( https://github.com/juanazam/bitvector/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
