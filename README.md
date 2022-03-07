# Sendgrid::Object

This gem provide classes for an easy use of the [sendrig-ruby](https://github.com/sendgrid/sendgrid-ruby) official gem.

## Prerequisites

Ruby version >= 2.4 (except version [2.6.0](https://github.com/sendgrid/sendgrid-ruby/blob/main/TROUBLESHOOTING.md#ruby-versions))

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sendgrid-object'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install sendgrid-object

## Configuration

You need to configure the api key with the following code. You can add it in `/config/initializers/sendgrid.rb` for example.

```ruby
require 'sendgrid-object'

Sendgrid.config do
  api_key    'YOUR_API_KEY_HERE'
end
```

## Quick start

### Find a recipient

```ruby
recipient = Sendgrid::Recipient.new()
recipient.find_by("email", "john@doe.com")
=> {"id"=>"ID", "email"=>"john@doe.com", "created_at"=>TIMESTAMP, "updated_at"=>TIMESTAMP, "last_emailed"=>TIMESTAMP, "last_clicked"=>TIMESTAMP, "last_opened"=>TIMESTAMP, "first_name"=>"John", "last_name"=>"Doe"} 
unless recipient.errors
    puts recipient.id
    puts recipient.email
    puts recipient.first_name
    puts recipient.last_name
end
```

### Create a recipient

```ruby
recipient = Sendgrid::Recipient.new()
recipient.create({ email: "jane@doe.com" })
=> "ID"
unless recipient.errors
    puts recipient.id
    puts recipient.email
    puts recipient.first_name
    puts recipient.last_name
end
```

### Add a recipient to an existing list

```ruby
recipient = Sendgrid::Recipient.new()
recipient.find_by("email", "john@doe.com")
list = Sendgrid::List.new()
list.add_recipient(recipient.id, ID_OF_THE_LIST)
=> nil
unless list.errors
    puts "User successfully added."
end
```

OR

```ruby
recipient = Sendgrid::Recipient.new()
recipient.find_by("email", "john@doe.com")
list = Sendgrid::List.new()
sendgrid_list.find(ID_OF_THE_LIST)
=> {"id"=>ID_OF_THE_LIST, "name"=>"NAME", "recipient_count"=>NB} 
list.add_recipient(recipient.id)
=> nil
puts "User successfully added." unless list.errors
```

### Destroy a recipient

```ruby
recipient = Sendgrid::Recipient.new()
recipient.find_by("email", "john@doe.com")
=> {"id"=>"ID", "email"=>"john@doe.com", "created_at"=>TIMESTAMP, "updated_at"=>TIMESTAMP, "last_emailed"=>TIMESTAMP, "last_clicked"=>TIMESTAMP, "last_opened"=>TIMESTAMP, "first_name"=>"John", "last_name"=>"Doe"} 
unless recipient.errors
    recipient.destroy
    puts "User successfully destroyed." unless recipient.errors
end
```

OR

```ruby
recipient = Sendgrid::Recipient.new()
recipient.destroy("ID")
puts "User successfully destroyed." unless recipient.errors
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/immateriel/sendgrid-object. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/immateriel/sendgrid-object/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
