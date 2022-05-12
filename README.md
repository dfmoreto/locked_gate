# LockedGate
This gems opens your Rails endpoints only with the right key

It performs authentication on Rails applications using JWT tokens and generate a model to access authenticated user data 

## Usage

1. After installing it, include **LockedGate** on your controller and add a `before_action` to `authenticate_user!`

```ruby
class ApplicationController
  include LockedGate

  before_action :authenticate_user!

  ...
end
```

2. Above steps will fulfill a **LockedGate::Key** with :user, :token and :expiration. 

So, if my JWT token has a following claim:
```ruby
{
  'email' => 'test@test.com',
  'exp' => 1652368277
}
```

**LockedGate::Key** resource is a [CurrentAttribute](https://api.rubyonrails.org/classes/ActiveSupport/CurrentAttributes.html) can be called **anywhere** in your Rails applicaiton this way
```ruby
LockedGate::Key.user # returns the following hash: { email: 'test@test.com' }
LockedGate::Key.expiration # returns the expiration as Time.zone
LockedGate::Key.token # returns the JWT token send to authenticate
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem "locked_gate"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install locked_gate
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
